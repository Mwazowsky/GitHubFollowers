//
//  UserQueryEntity+Mapping.swift
//  UIkitZeroToHero
//
//  Created by MacBook Air MII  on 07/02/25.
//

import Foundation
import CoreData

extension UserQueryEntity {
    convenience init(
        userQuery: UserQuery,
        insertInto context: NSManagedObjectContext
    ) {
        self.init(context: context)
        query = userQuery.query
        createdAt = Date()
    }
}

extension UserQueryEntity {
    func toDomain() -> UserQuery {
        return .init(query: query ?? "")
    }
}


