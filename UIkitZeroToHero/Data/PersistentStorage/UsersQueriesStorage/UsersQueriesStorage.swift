//
//  UsersQueriesStorage.swift
//  UIkitZeroToHero
//
//  Created by MacBook Air MII  on 07/02/25.
//

import Foundation

protocol UsersQueriesStorage {
    func fetchRecentQueries(
        maxCount: Int,
        completion: @escaping (Result<[UserQuery], Error>) -> Void
    )
    
    
    func saveRecentQuery(
        query: UserQuery,
        completion: @escaping (Result<UserQuery, Error>) -> Void
    )
}
