//
//  UsersQueriesRepository.swift
//  UIkitZeroToHero
//
//  Created by Saifulloh Fadli on 07/02/25.
//

import Foundation

protocol UsersQueriesRepository {
    func fetchRecentsQueries(
        maxCount: Int,
        completion: @escaping (Result<[UserQuery], Error>) -> Void
    )
    func saveRecentQuery(
        query: UserQuery,
        completion: @escaping (Result<UserQuery, Error>) -> Void
    )
}
