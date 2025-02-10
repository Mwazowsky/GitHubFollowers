//
//  DefaultUsersRepository.swift
//  UIkitZeroToHero
//
//  Created by MacBook Air MII  on 07/02/25.
//

import Foundation

final class DefaultProfileImagesRepository {
    private let dataTransferService: DataTransferService
    private let backgroundQueue: DataTransferDispatchQueue
    
    init(
        dataTransferService: DataTransferService,
        backgroundQueue: DataTransferDispatchQueue = DispatchQueue.global(qos: .userInitiated)
    ) {
        self.dataTransferService = dataTransferService
        self.backgroundQueue = backgroundQueue
    }
}

extension DefaultProfileImagesRepository: ProfileImagesRepository {
    func fetchImage(
        with imagePath: String,
        width: Int,
        completion: @escaping (Result<Data, any Error>) -> Void
    ) -> (any Cancellable)? {
        let endpoint = APIEndpoints.getProfileImage(path: imagePath, width: width)
        let task = RepositoryTask()
        
        task.networkTask = dataTransferService.request(
            with: endpoint,
            on: backgroundQueue
        ) { (result: Result<Data, DataTransferError>) in
            let result = result.mapError{ $0 as Error }
            completion(result)
        }
        
        return task
    }
}
