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

enum UserFlow {
    case auth
    case main
}

class FirebaseAuthManager: FirebaseAuthManagerProtocol {
    
    enum Constants {
        static let one = 1
        static let slash = "/"
        static let defaultName = "User"
        static let winRate = "0 %"
        static let defaultCoinBalance = 2000
        static let defaultAnonymousUser = "AnonymousUser_0"
        static let anonymousUserName = "AnonymousUser"
        static let separatingComponent = "_"
    }
    
    private let auth = Auth.auth()
    private let database = Database.database().reference()
    
    func startAuthorizationObserver(completion: @escaping ((UserFlow) -> Void)) {
        auth.addStateDidChangeListener { auth, user in
            if user == nil { completion(.auth) }
            else { completion(.main) }
        }
    }
    
    func signUp(withEmail email: String, password: String, userName: String, completion: @escaping ((Resulter<RegistrationError>) -> Void)) {
        auth.createUser(withEmail: email, password: password) {[weak self] result, error in
            guard let self = self else { return }
            
            if let error = self.checkForError(error, type: RegistrationError.self) {
                completion(.failure(error.error))
            }
            
            guard let uid = result?.user.uid else {
                completion(.failure(.defaultError))
                return
            }

            self.getOrSetUserData(userId: uid, userName: userName) { result in
                switch result {
                case .success: completion(.success)
                case .failure(let error): completion(.failure(.defaultError))
                }
            }
        }
    }
    
    // MARK: - signIn with Email
    func signIn(with data: SignInRequest, completion: @escaping ((Resulter<AuthErrors>) -> Void)) {
        auth.signIn(withEmail: data.email, password: data.password) { [weak self] result, error in
            guard let self = self else { return }
            
            if let error = self.checkForError(error, type: AuthErrors.self) {
                completion(.failure(error.error))
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
    
    // MARK: - Sign in with Google
    func signInWithGoogle(presenting: UIViewController,
                          completion: @escaping ((Resulter<AuthErrors>) -> Void)) {
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
    
    private func signInWithGoogle(with credential: AuthCredential, completion: @escaping ((Resulter<AuthErrors>) -> Void)) {
        auth.signIn(with: credential) { [weak self] result, error in
            guard let self = self else { return }
            
            
            if let error = self.checkForError(error, type: AuthErrors.self) {
                completion(.failure(error.error))
            }
            
            guard let user = result?.user else { return }
            self.getOrSetUserData(userId: user.uid, userName: user.displayName ?? Constants.defaultName) { result in
                completion(result)
            }
        }
    }
    
    // MARK: - Sign in Anonymously
    func signInAnonymously(completion: @escaping ((Resulter<AuthErrors>) -> Void)) {
        auth.signInAnonymously { [weak self] result, error in
            guard let self = self else { return }
            
            if let error = self.checkForError(error, type: AuthErrors.self) {
                completion(.failure(error.error))
            }
            
            guard let uid = result?.user.uid else { return }
            
            self.setNameToAnonymousUser { result in
                switch result {
                case .failure(let error): completion(.failure(error))
                case .success(let userName):
                    self.createUserRecordInDatabase(with: uid, userName: userName) { createUserRecordResult in
                        completion(createUserRecordResult)
                    }
                }
            }
        }
    }
    
    private func setNameToAnonymousUser(completion: @escaping ((Result<String, AuthErrors>) -> Void)) {
        let path = DatabasePaths.users + DatabasePaths.anonymousUserNames
        database.child(path).getData { [weak self] error, snapshot in
            guard let self = self else { return }
            
            if let error = self.checkForError(error, type: AuthErrors.self) {
                completion(.failure(error.error))
            }
            
            guard
                var value = snapshot?.value as? [String],
                let lastName = value.last,
                let userStringNumber = lastName.components(separatedBy: Constants.separatingComponent).last,
                let userNumber = userStringNumber.toInt()
            else {
                self.database.child(path).setValue([Constants.defaultAnonymousUser])
                completion(.success(Constants.defaultAnonymousUser))
                return
            }
            
            let userName = Constants.anonymousUserName + Constants.separatingComponent + "\(userNumber + Constants.one)"
            value.append(userName)
            self.database.child(path).setValue(value)
            completion(.success(userName))
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func createUserRecordInDatabase(with id: String, userName: String, completion: @escaping ((Resulter<AuthErrors>) -> Void)) {
        guard let deviceID = getDeviceId() else { return }
        
        let record: [String: Any] = [DatabaseKeys.deviceIds: [deviceID],
                                     DatabaseKeys.uid: id,
                                     DatabaseKeys.coinBalance: Constants.defaultCoinBalance,
                                     DatabaseKeys.winRate: Constants.winRate,
                                     DatabaseKeys.userName: userName]
        let path = DatabasePaths.users + id
        database.child(path).setValue(record) { [weak self] error, _ in
            guard let self = self else { return }
            
            if let error = self.checkForError(error, type: AuthErrors.self) {
                completion(.failure(error.error))
            }
            
            completion(.success)
        }
    }
}

// MARK: - The methods for add user id and device id in Firebase
private extension FirebaseAuthManager {
    
    func getUserDeviceIdsFromFirebase(userId id: String, completion: @escaping ((Resulter<AuthErrors>) -> Void)) {
        let path = DatabasePaths.users + id + Constants.slash + DatabasePaths.deviceIds
        database.child(path).getData { [weak self] error, snapshot in
            guard let self = self else { return }
            
            if let error = self.checkForError(error, type: AuthErrors.self) {
                completion(.failure(error.error))
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
    
    func getOrSetUserData(userId id: String, userName: String, completion: @escaping ((Resulter<AuthErrors>) -> Void)) {
        let path = DatabasePaths.users + id
        
        database.child(path).getData { [weak self] error, snapshot in
            guard let self = self else { return }
            
            if let error = self.checkForError(error, type: AuthErrors.self) {
                completion(.failure(error.error))
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
    
    func addDeviceIdToUser(deviceIds: [String], user id: String, completion: @escaping ((Resulter<AuthErrors>) -> Void)) {
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
                
                if let error = self.checkForError(error, type: AuthErrors.self) {
                    completion(.failure(error.error))
                }
                
                completion(.success)
            }
        }
        completion(.success)
    }
    
    func getDeviceId() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
}

// MARK: - Error processing
private extension FirebaseAuthManager {
    
    func checkForError<T>(_ error: Error?, type: T.Type) -> FirebaseError<T>? {
        if let error = error {
            return self.errorParsing(error, type: type)
        }
        
        return nil
    }
}
