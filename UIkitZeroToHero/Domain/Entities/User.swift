//
//  User.swift
//  UIkitZeroToHero
//
//  Created by Saifulloh Fadli on 06/02/25.
//

import Foundation

struct User: Equatable, Identifiable {
    typealias Identifier = String
    
    var id: Identifier
    var name: String
    var email: String
}


struct UsersPage: Equatable {
    let page: Int
    let totalPages: Int
    let users: [User]
}
