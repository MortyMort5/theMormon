//
//  User.swift
//  TheMormons
//
//  Created by Sterling Mortensen on 12/19/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import Foundation
import UIKit
class User {
    
    private let idKey = "id"
    private let firstNameKey = "firstName"
    private let lastNameKey = "lastName"
    private let birthdateKey = "birthdate"
    private let profilePictureEndPointKey = "profilePicture"
    private let profileImageURLKey = "imageURL"
    private let forceSensitiveKey = "forceSensitive"
    private let affiliationKey = "affiliation"
    private let imageDataKey = "imageData"
    
    var id: Int
    var firstName: String
    var lastName: String
    var birthdate: String
    var forceSensitive: Bool
    var affiliation: String
    var profilePictureEndPoint: String
    var profilePicture: UIImage?
    var profilePictureURL: String {
        return "\(profilePictureEndPoint)"
    }
    
        // MARK: - Converts JSON data into User Objects
    init?(jsonDictionary: [String: Any]) {
        guard let id = jsonDictionary[idKey] as? Int,
            let firstName = jsonDictionary[firstNameKey] as? String,
            let lastName = jsonDictionary[lastNameKey] as? String,
            let birthdate = jsonDictionary[birthdateKey] as? String,
            let profilePictureEndPoint = jsonDictionary[profilePictureEndPointKey] as? String,
            let forceSensitive = jsonDictionary[forceSensitiveKey] as? Bool,
            let affiliation = jsonDictionary[affiliationKey] as? String else { return nil }
        
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.birthdate = birthdate
        self.forceSensitive = forceSensitive
        self.affiliation = affiliation
        self.profilePictureEndPoint = profilePictureEndPoint
    }
    
        // MARK: - Converts dictionaries saved locally into User Objects
    init?(dictionary: [String: Any]) {
        guard let id = dictionary[idKey] as? Int,
            let firstName = dictionary[firstNameKey] as? String,
            let lastName = dictionary[lastNameKey] as? String,
            let birthdate = dictionary[birthdateKey] as? String,
            let profilePictureEndPoint = dictionary[profilePictureEndPointKey] as? String,
            let forceSensitive = dictionary[forceSensitiveKey] as? Bool,
            let affiliation = dictionary[affiliationKey] as? String,
            let imageData = dictionary[imageDataKey] as? Data else { return nil }
        
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.birthdate = birthdate
        self.forceSensitive = forceSensitive
        self.affiliation = affiliation
        self.profilePictureEndPoint = profilePictureEndPoint
        let image = UIImage(data: imageData, scale: 1)
        self.profilePicture = image
    }
    
        // MARK: - Converts User objects into Dictionaries
    var dictionaryRepresentation: [String: Any] {
        guard let profilePic = profilePicture else { return [:] }
        guard let data = UIImagePNGRepresentation(profilePic) else { return [:] }
        let dictionary = [idKey: id, firstNameKey: firstName, lastNameKey: lastName, birthdateKey: birthdate, forceSensitiveKey: forceSensitive, affiliationKey: affiliation, profilePictureEndPointKey: profilePictureEndPoint, imageDataKey: data] as [String : Any]
        return dictionary
    }
}
