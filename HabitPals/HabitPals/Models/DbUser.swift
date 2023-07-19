//
//  User.swift
//  HabitPals
//
//  Created by Ionut Grosu on 14/07/2023.
//

import Foundation

struct DbUser: Codable, Hashable {
    var name: String?
    var email: String?
    var authId: String
    var pictureURL: String?
    
    init(name: String, email: String, authId: String, pictureURL: String) {
        self.name = name
        self.email = email
        self.authId = authId
        self.pictureURL = pictureURL
    }
    
    init(auth: AuthDataResultModel) {
        self.name = auth.name
        self.email = auth.email
        self.authId = auth.uid
        self.pictureURL = auth.photoUrl
      }
    
    static var emptyUser: DbUser {
        return DbUser(name: "", email: "", authId: "", pictureURL: "")
    }
}
