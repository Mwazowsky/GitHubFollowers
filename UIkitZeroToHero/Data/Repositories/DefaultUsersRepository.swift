//
//  DefaultUsersRepository.swift
//  UIkitZeroToHero
//
//  Created by MacBook Air MII  on 07/02/25.
//

import Foundation

final class DefaultUsersRepository {
    private let dataTransferService: DataTransferService
    private let cache: UsersResponseStorage
    private let backgroundQueue: DataTransferDispatchQueue
    
    init(
        dataTransferService: DataTransferService,
        cache: UsersResponseStorage,
        backgroundQueue: DataTransferDispatchQueue = DispatchQueue.global(qos: .userInitiated)
    ) {
        self.dataTransferService = dataTransferService
        self.cache = cache
        self.backgroundQueue = backgroundQueue
    }
}


extension DefaultUsersRepository: UsersRepository {
    func fetchUsersList(
        query: UserQuery,
        page: Int,
        cached: @escaping (UsersPage) -> Void,
        completion: @escaping (Result<UsersPage, any Error>) -> Void) -> (any Cancellable)?
    {
        let requestDTO = UsersRequestDTO(query: query.query, page: page)
        let task = RepositoryTask()
        
        cache.getResponse(for: requestDTO) { [weak self, backgroundQueue] result in
            if case let .success(responseDTO?) = result {
                cached(responseDTO.toDomain())
            }
            guard !task.isCancelled else { return }
            
            let endpoint = APIEndpoints.getUsers(with: requestDTO)
            task.networkTask = self?.dataTransferService.request(
                with: endpoint,
                on: backgroundQueue
            ) { result in
                switch result {
                case .success(let responseDTO):
                    self?.cache.save(response: responseDTO, for: requestDTO)
                    completion(.success(responseDTO.toDomain()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        
        return task
    }
}
