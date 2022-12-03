//
//  FirebaseAuthManager.swift
//  Roulette game
//
//  Created by Максим Михальчук on 02.12.2022.
//

import Foundation
import Firebase
import UIKit
import GoogleSignIn

enum AuthState {
    case auth
    case notAuth
}

class FirebaseAuthManager: FirebaseAuthManagerProtocol {
    
    enum Constants {
        static let slash = "/"
        static let defaultName = "User"
        static let winRate = "0 %"
        static let defaultCoinBalance = 2000
    }
    
    private let auth = Auth.auth()
    private let database = Database.database().reference()
    
    func startAuthorizationObserver(completion: @escaping ((AuthState) -> Void)) {
        auth.addStateDidChangeListener { auth, user in
            if user == nil { completion(.notAuth) }
            else { completion(.auth) }
        }
    }
    
    func signIn(with data: SignInRequest,
                completion: @escaping ((Result<Bool, AuthErrors>) -> Void)) {
        auth.signIn(withEmail: data.email, password: data.password) { [weak self] result, error in
            guard let self = self else { return }
            
            self.checkError(error: error) { error in
                completion(.failure(error))
            }

            guard let uid = result?.user.uid else {
                completion(.failure(.defaultError))
                return
            }
            
            self.getUserDeviceIdsFromFirebase(userId: uid) { result in
                completion(result)
            }
        }
        
    }
    
    func signInWithGoogle(presenting: UIViewController, completion: @escaping ((Result<Bool, AuthErrors>) -> Void)) {
        guard let clientId = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientId)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: presenting) { [weak self] user, error in
            guard let self = self else { return }
            
            if error != nil {
                completion(.failure(.defaultError))
                return
            }
            
            guard
                let userAuth = user?.authentication,
                let idToken = userAuth.idToken
            else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: userAuth.accessToken)
            self.signInWithGoogle(with: credential) { result in
                completion(result)
            }
        }
    }
    
    private func signInWithGoogle(with credential: AuthCredential, completion: @escaping ((Result<Bool, AuthErrors>) -> Void)) {
        auth.signIn(with: credential) { [weak self] result, error in
            guard let self = self else { return }
            
            self.checkError(error: error) { error in
                completion(.failure(error))
            }
            
            guard let user = result?.user else { return }
            self.getOrSetUserData(userId: user.uid, userName: user.displayName ?? Constants.defaultName) { result in
                completion(result)
            }
        }
    }
    
    func signInWithAnonymously() {
        auth.signInAnonymously { result, error in
            print("")
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func checkError(error: Error?,
                            completion: @escaping ((AuthErrors) -> Void)) {
        if let error = error {
            let getError = self.firebaseAuthErrorParsing(from: error)
            completion(getError)
            return
        }
    }
    
    private func createUserRecordInDatabase(with id: String, userName: String, completion: @escaping ((Result<Bool, AuthErrors>) -> Void)) {
        guard let deviceID = getDeviceId() else { return }
        
        let record: [String: Any] = [DatabaseKeys.deviceIds: [deviceID],
                                     DatabaseKeys.uid: id,
                                     DatabaseKeys.coinBalance: Constants.defaultCoinBalance,
                                     DatabaseKeys.winRate: Constants.winRate,
                                     DatabaseKeys.userName: userName]
        let path = DatabasePaths.users + id
        database.child(path).setValue(record) { [weak self] error, _ in
            guard let self = self else { return }
            
            self.checkError(error: error) { error in
                completion(.failure(error))
            }
            
            completion(.success(true))
        }
    }
}

// MARK: - The methods for add user id and device id in Firebase
private extension FirebaseAuthManager {
    
    func getUserDeviceIdsFromFirebase(userId id: String, completion: @escaping ((Result<Bool, AuthErrors>) -> Void)) {
        let path = DatabasePaths.users + id + Constants.slash + DatabasePaths.deviceIds
        database.child(path).getData { [weak self] error, snapshot in
            guard let self = self else { return }
            
            self.checkError(error: error) { error in
                completion(.failure(error))
            }
            
            guard let deviceIds = snapshot?.value as? [String] else {
                completion(.failure(.userRecordNotFound))
                return
            }
            
            self.addDeviceIdToUser(deviceIds: deviceIds, user: id) { result in
                completion(result)
            }
        }
    }
    
    func getOrSetUserData(userId id: String, userName: String, completion: @escaping ((Result<Bool, AuthErrors>) -> Void)) {
        let path = DatabasePaths.users + id
        
        database.child(path).getData { [weak self] error, snapshot in
            guard let self = self else { return }
            
            self.checkError(error: error) { error in
                completion(.failure(error))
            }
            
            if let snap = snapshot?.value as? [String: Any] {
                guard let deviceIds = snap[DatabaseKeys.deviceIds] as? [String] else { return }
                self.addDeviceIdToUser(deviceIds: deviceIds, user: id) { result in
                    completion(result)
                }
            } else {
                self.createUserRecordInDatabase(with: id, userName: userName) { result in
                    completion(result)
                }
            }
        }
    }
    
    func addDeviceIdToUser(deviceIds: [String], user id: String, completion: @escaping ((Result<Bool, AuthErrors>) -> Void)) {
        guard let deviceId = getDeviceId() else { return }
        
        if !deviceIds.contains(deviceId) {
            var deviceIds = deviceIds
            deviceIds.append(deviceId)
            let path = DatabasePaths.users
            + id
            + Constants.slash
            + DatabasePaths.deviceIds
            database.child(path).setValue(deviceIds) { [weak self] error, _ in
                guard let self = self else { return }
                
                self.checkError(error: error) { error in
                    completion(.failure(error))
                }
                
                completion(.success(true))
            }
        }
        completion(.success(true))
    }
    
    func getDeviceId() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
}
