//
//  User.swift
//  HabitPals
//
//  Created by Ionut Grosu on 14/07/2023.
//

import Foundation

struct User: Codable {
    var name: String
    var email: String
    var authId: String
    var pictureURL: String
    
    init(name: String, email: String, authId: String, pictureURL: String) {
        self.name = name
        self.email = email
        self.authId = authId
        self.pictureURL = pictureURL
    }
    
    var dictionary: [String: Any] {
        return [
            "name": self.name,
            "email": self.email,
            "authId": self.authId,
            "pictureURL": self.pictureURL
        ]
    }
    
    static var emptyUser: User {
        return User(name: "", email: "", authId: "", pictureURL: "")
    }
}
