//
//  UserRepository.swift
//  UIkitZeroToHero
//
//  Created by Saifulloh Fadli on 06/02/25.
//

import Foundation

protocol UsersRepository {
    @discardableResult
    func fetchUsersList(
        query: UserQuery,
        page: Int,
        cached: @escaping (UsersPage) -> Void,
        completion: @escaping (Result<UsersPage, Error>) -> Void
    ) -> Cancellable?
}
