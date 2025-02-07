import UIKit
import SwiftUI

final class UsersSceneDIContainer: UsersSearchFlowCoordinatorDependencies {
    struct Dependencies {
        let apiDataTransferService: DataTransferService
        let imageDataTransferService: DataTransferService
    }
    
    
    private let dependencies: Dependencies
    
    // MARK: - Persistent Storage
    lazy var usersQueriesStorage: UsersQueriesStorage = CoreDataUsersQueriesStorage(maxStorageLimit: 10)
    
    lazy var userResponseCache: UsersResponseStorage = CoreDa
}
