//
//  UserDefaultsUsersQueriesStorage.swift
//  UIkitZeroToHero
//
//  Created by MacBook Air MII  on 07/02/25.
//

import Foundation

final class UserDefaultsUsersQueriesStorage {
    private let maxStorageLimit: Int
    private let recentsUsersQueriesKey = "recentsUsersQueries"
    private var userDefaults: UserDefaults
    private let backgroundQueue: DispatchQueueType
    
    init(
        maxStorageLimit: Int,
        userDefaults: UserDefaults = UserDefaults.standard,
        backgroundQueue: DispatchQueueType = DispatchQueue.global(qos: .userInitiated)
    ) {
        self.maxStorageLimit = maxStorageLimit
        self.userDefaults = userDefaults
        self.backgroundQueue = backgroundQueue
    }
    
    private func fetchUsersQueries() -> [UserQuery] {
        if let queriesData = userDefaults.object(forKey: recentsUsersQueriesKey) as? Data {
            if let userQueryList = try? JSONDecoder().decode(UserQueriesListUDS.self, from: queriesData) {
                return userQueryList.list.map { $0.toDomain() }
            }
        }
        return []
    }
    
    private func persist(usersQueries: [UserQuery]) {
        let encoder = JSONEncoder()
        let userQueryUDSs = usersQueries.map(UserQueryUDS.init)
        if let encoded = try? encoder.encode(UserQueriesListUDS(list: userQueryUDSs)) {
            userDefaults.set(encoded, forKey: recentsUsersQueriesKey)
        }
    }
}


extension UserDefaultsUsersQueriesStorage: UsersQueriesStorage {
    func fetchRecentQueries(
        maxCount: Int,
        completion: @escaping (Result<[UserQuery], Error>) -> Void
    ) {
        backgroundQueue.async { [weak self] in
            guard let self = self else { return }
            
            var queries = self.fetchUsersQueries()
            queries = queries.count < self.maxStorageLimit ? queries : Array(queries[0..<maxCount])
            
            completion(.success(queries))
        }
    }
    
    func saveRecentQuery(
        query: UserQuery,
        completion: @escaping (Result<UserQuery, Error>) -> Void
    ) {
        backgroundQueue.async { [weak self] in
            guard let self = self else { return }
            
            var queries = self.fetchUsersQueries()
            self.cleanUpQueries(for: query, in: &queries)
            queries.insert(query, at: 0)
            self.persist(usersQueries: queries)
            
            completion(.success(query))
        }
    }
}


// MARK: - Private
extension UserDefaultsUsersQueriesStorage {
    private func cleanUpQueries(for query: UserQuery, in queries: inout [UserQuery]) {
        removeDuplicates(for: query, in: &queries)
        removeQueries(limit: maxStorageLimit-1, in: &queries)
    }
    
    private func removeDuplicates(for query: UserQuery, in queries: inout [UserQuery]) {
        queries = queries.filter { $0 != query }
    }

    private func removeQueries(limit: Int, in queries: inout [UserQuery]) {
        queries = queries.count <= limit ? queries : Array(queries[0..<limit])
    }
}
