//
//  FirebaseMainManager.swift
//  Roulette game
//
//  Created by Максим Михальчук on 05.12.2022.
//

import Firebase

class FirebaseMainManager: FirebaseMainManagerProtocol {
    
    private enum Constants {
        static let slash = "/"
    }
    
    private let database = Database.database().reference()
    
    func getUserData(for id: String, completion: @escaping BlockWith<Result<User, Error>>) {
        let path = DatabasePaths.users + id
        
        database.child(path).observe(.value) { [weak self] snapshot in
            guard let self = self, let value = snapshot.value else { return }
            
            self.parsingData(value, decodeType: User.self) { result in
                completion(result)
            }
        }
    }
    
    func parsingData<T: Codable>(_ data: Any, decodeType: T.Type, completion: @escaping BlockWith<Result<T, Error>>) {
        do {
            let data = try JSONSerialization.data(withJSONObject: data)
            let json = try JSONDecoder().decode(T.self, from: data)
            completion(.success(json))
        } catch {
            completion(.failure(error))
        }
    }
}
