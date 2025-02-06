//
//  SearchUsersUseCase.swift
//  UIkitZeroToHero
//
//  Created by Saifulloh Fadli on 06/02/25.
//

import Foundation

protocol SearchUsersUseCase {
    func execute(
        requestValue: SearchUsersUseCaseRequestValue,
        cached: @escaping (UsersPage) -> Void,
        completion: @escaping (Result<UsersPage, Error>) -> Void
    ) -> Cancellable?
}

final class DefaultSearchUsersUseCase: SearchUsersUseCase {
    private let usersRepositories: UsersRepository
    private let usersQueriesRepositories: UsersQueriesRepository
    
    init(
        usersRepositories: UsersRepository,
        usersQueriesRepositories: UsersQueriesRepository
    ) {
        self.usersRepositories = usersRepositories
        self.usersQueriesRepositories = usersQueriesRepositories
    }
    
    
    func execute(
        requestValue: SearchUsersUseCaseRequestValue,
        cached: @escaping (UsersPage) -> Void,
        completion: @escaping (Result<UsersPage, Error>) -> Void
    ) -> Cancellable? {
        return usersRepositories.fetchUsersList(
            query: requestValue.query,
            page: requestValue.page,
            cached: cached,
            completion: { result in
                if case .success = result {
                    self.usersQueriesRepositories.saveRecentQuery(query: requestValue.query) { _ in }
                }
                
                completion(result)
            }
        )
    }
}

struct SearchUsersUseCaseRequestValue {
    let query: UserQuery
    let page: Int
}
