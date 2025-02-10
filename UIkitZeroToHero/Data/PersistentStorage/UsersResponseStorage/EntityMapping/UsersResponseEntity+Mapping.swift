//
//  UsersResponseEntity+Mapping.swift
//  UIkitZeroToHero
//
//  Created by MacBook Air MII  on 07/02/25.
//

import Foundation
import CoreData

extension UsersResponseEntity {
    func toDTO() -> UsersResponseDTO {
        return .init(
            page: Int(page),
            totalPages: Int(totalPages),
            users: users?.allObjects.map { ($0 as! UserResponseEntity).toDTO() } ?? []
        )
    }
}

extension UserResponseEntity {
    func toDTO() -> UsersResponseDTO.UserDTO {
        return .init(
            id: Int(id),
            email: email,
            name: name
        )
    }
}

extension UsersRequestDTO {
    func toEntity(in context: NSManagedObjectContext) -> UsersRequestEntity {
        let entity: UsersRequestEntity = .init(context: context)
        entity.query = query
        entity.page = Int32(page)
        return entity
    }
}

extension UsersResponseDTO {
    func toEntity(in context: NSManagedObjectContext) -> UsersResponseEntity {
        let entity: UsersResponseEntity = .init(context: context)
        entity.page = Int32(page)
        entity.totalPages = Int32(totalPages)
        users.forEach {
            entity.addToUsers($0.toEntity(in: context))
        }
        return entity
    }
}

extension UsersResponseDTO.UserDTO {
    func toEntity(in context: NSManagedObjectContext) -> UserResponseEntity {
        let entity: UserResponseEntity = .init(context: context)
        entity.id = Int64(id)
        entity.email = email
        entity.name = name
        return entity
    }
}
