//
//  UserQueryUDS+Mapping.swift
//  UIkitZeroToHero
//
//  Created by MacBook Air MII  on 07/02/25.
//

import Foundation

struct UserQueriesListUDS: Codable {
    var list: [UserQueryUDS]
}

struct UserQueryUDS: Codable {
    let query: String
}

extension UserQueryUDS {
    init(userQuery: UserQuery){
        query = userQuery.query
    }
}

extension UserQueryUDS {
    func toDomain() -> UserQuery {
        return .init(query: query)
    }
}
