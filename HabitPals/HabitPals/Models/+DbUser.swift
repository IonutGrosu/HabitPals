//
//  +DbUser.swift
//  HabitPals
//
//  Created by Ionut Grosu on 25/07/2023.
//

import Foundation

extension DbUser{
    init(auth: AuthDataResultModel) {
        self.name = auth.name
        self.email = auth.email
        self.authId = auth.uid
        self.pictureURL = auth.photoUrl
      }
}
