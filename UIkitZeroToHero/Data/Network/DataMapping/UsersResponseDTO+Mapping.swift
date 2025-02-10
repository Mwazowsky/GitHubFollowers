//
//  UsersResponseDTO+Mapping.swift
//  UIkitZeroToHero
//
//  Created by MacBook Air MII  on 07/02/25.
//

import Foundation

// MARK: - Data Transfer Object

struct UsersResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case users = "results"
    }
    let page: Int
    let totalPages: Int
    let users: [UserDTO]
}

extension UsersResponseDTO {
    struct UserDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case id
            case email
            case name
            case profileImagePath = "profile_image_path"
        }
        
        let id: Int
        let email: String?
        let name: String?
        let profileImagePath: String?
    }
}

// MARK: - Mappings to Domain

extension UsersResponseDTO {
    func toDomain() -> UsersPage {
        return .init(page: page,
                     totalPages: totalPages,
                     users: users.map { $0.toDomain() })
    }
}

extension UsersResponseDTO.UserDTO {
    func toDomain() -> User {
        return .init(
            id: User.Identifier(id),
            name: name ?? "",
            email: email ?? "",
            profileImagePath: profileImagePath
        )
    }
}

// MARK: - Private

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
}()

