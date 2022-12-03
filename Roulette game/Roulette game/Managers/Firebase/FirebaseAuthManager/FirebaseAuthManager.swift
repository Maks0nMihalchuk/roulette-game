//
//  FirebaseAuthManager.swift
//  Roulette game
//
//  Created by Максим Михальчук on 02.12.2022.
//

import Foundation
import Firebase
import UIKit

enum AuthState {
    case auth
    case notAuth
}

class FirebaseAuthManager: FirebaseAuthManagerProtocol {
    
    enum Constants {
        static let slash = "/"
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
            
            if let error = error {
                let authError = self.authErrorParsing(from: error)
                completion(.failure(authError))
                return
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
    
    func signInWithGoogle() {
//        auth.signIn(with: <#T##AuthCredential#>, completion: <#T##((AuthDataResult?, Error?) -> Void)?##((AuthDataResult?, Error?) -> Void)?##(AuthDataResult?, Error?) -> Void#>)
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
    
}

// MARK: - The methods for add user id and device id in Firebase
private extension FirebaseAuthManager {
    
    func getUserDeviceIdsFromFirebase(userId id: String, completion: @escaping ((Result<Bool, AuthErrors>) -> Void)) {
        let path = DatabasePaths.users + id + Constants.slash + DatabasePaths.deviceIds
        database.child(path).getData { [weak self] error, snapshot in
            guard let self = self else { return }
            
            if let error = error {
                let getDataError = self.authErrorParsing(from: error)
                completion(.failure(getDataError))
                return
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
                
                if let error = error {
                    let setValueError = self.authErrorParsing(from: error)
                    completion(.failure(setValueError))
                    return
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
