//
//  DefaultUsersRepository.swift
//  UIkitZeroToHero
//
//  Created by MacBook Air MII  on 07/02/25.
//

import Foundation

final class DefaultUsersQueriesRepository {
    private var usersQueriesPersistentStorage: UsersQueriesStorage
    
    init(usersQueriesPersistentStorage: UsersQueriesStorage) {
        self.usersQueriesPersistentStorage = usersQueriesPersistentStorage
    }
}

extension DefaultUsersQueriesRepository: UsersQueriesRepository {
    func fetchRecentsQueries(
        maxCount: Int,
        completion: @escaping (Result<[UserQuery], any Error>) -> Void
    ) {
        return usersQueriesPersistentStorage.fetchRecentQueries(
            maxCount: maxCount,
            completion: completion
        )
    }
    
    func saveRecentQuery(
        query: UserQuery,
        completion: @escaping (Result<UserQuery, any Error>) -> Void
    ) {
        usersQueriesPersistentStorage.saveRecentQuery(
            query: query,
            completion: completion
        )
    }
}
