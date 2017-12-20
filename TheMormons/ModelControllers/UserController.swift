//
//  UserController.swift
//  TheMormons
//
//  Created by Sterling Mortensen on 12/19/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import Foundation

class UserController {
    
        // MARK: - Private Keys
    private let userKey = "user"
        // MARK: - Singleton
    static let shared = UserController()
        // MARK: - URL
    let baseURL = URL(string: "https://edge.ldscdn.org/mobile/interview/directory")
    
    var users: [User] = [] 
    
    init() {
        loadFromPersistentStorage()
    }
    
        // MARK: - Makes a GET call to the API and brings down json and turns it into a User object
    func fetchUsers(completion: @escaping() -> Void) {
        
        guard let url = baseURL else { print("Error with unwrapping the baseURL"); completion(); return }
        
        NetworkController.performRequest(for: url, httpMethod: .Get, urlParameters: nil) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                completion()
                return
            }
            
            guard let data = data,
                let responseStringData = String(data: data, encoding: .utf8) else { print("Error with responseStringData"); completion(); return }
            
            guard let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any],
                let userDictionary = jsonDictionary["individuals"] as? [[String: Any]] else { print("Error with serializing data. Response: \(responseStringData)"); completion(); return }
            
            let users = userDictionary.flatMap({ User(jsonDictionary: $0) })
            
            let group = DispatchGroup()
            
            for user in users {
                group.enter()
                ImageController.image(forURL: user.profilePictureURL, completion: { (image) in
                    user.profilePicture = image
                    group.leave()
                })
            }
        
            group.notify(queue: DispatchQueue.main, execute: {
                self.users = users
                self.saveToPersistentStorage()
                completion()
            })
        }
    }
    
        // MARK: - Saves all the data locally
    func saveToPersistentStorage() {
        var userArray: [[String: Any]] = []
        for user in users {
            let dictionary = user.dictionaryRepresentation
            userArray.append(dictionary)
        }
        UserDefaults.standard.set(userArray, forKey: userKey)
    }
    
        // MARK: - Loads all the data that was saved locally
    func loadFromPersistentStorage() {
        if let usersArrayDictionary = UserDefaults.standard.object(forKey: userKey) as? [[String: Any]] {
            var userArray: [User] = []
            for userDictionary in usersArrayDictionary {
                if let user = User(dictionary: userDictionary as [String : Any]) {
                    userArray.append(user)
                }
            }
            self.users = userArray
        }
    }
}
