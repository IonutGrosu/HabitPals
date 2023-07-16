//
//  User.swift
//  HabitPals
//
//  Created by Ionut Grosu on 14/07/2023.
//

import Foundation

struct DbUser: Codable {
    var email: String?
    var authId: String
    var pictureURL: String?
    
    init(email: String, authId: String, pictureURL: String) {
        self.email = email
        self.authId = authId
        self.pictureURL = pictureURL
    }
    
    init(auth: AuthDataResultModel) {
        self.email = auth.email
        self.authId = auth.uid
        self.pictureURL = auth.photoUrl
      }
    
    static var emptyUser: DbUser {
        return DbUser(email: "", authId: "", pictureURL: "")
    }
}
