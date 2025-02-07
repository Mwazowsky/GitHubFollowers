//
//  FetchRecentUserQueriesUseCase.swift
//  UIkitZeroToHero
//
//  Created by MacBook Air MII  on 07/02/25.
//

import Foundation

// This is another option to create Use Case using more generic way
final class FetchRecentUserQueriesUseCase: UseCase {
    
    struct RequestValue {
        let maxCount: Int
    }
    typealias ResultValue = (Result<[UserQuery], Error>)
    
    private let requestValue: RequestValue
    private let completion: (ResultValue) -> Void
    private let userQueriesRepository: UsersQueriesRepository
    
    
    init(
        requestValue: RequestValue,
        completion: @escaping (ResultValue) -> Void,
        userQueriesRepository: UsersQueriesRepository
    ) {
        self.requestValue = requestValue
        self.completion = completion
        self.userQueriesRepository = userQueriesRepository
    }
    
    
    func start() -> Cancellable? {
        userQueriesRepository.fetchRecentsQueries(
            maxCount: requestValue.maxCount,
            completion: completion
        )
        return nil
    }
}
