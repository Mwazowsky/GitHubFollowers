import UIKit
import SwiftUI

final class UsersSceneDIContainer: UsersSearchFlowCoordinatorDependencies {
    func makeUserssListViewController(actions: UsersListViewModelActions) -> UsersListViewController {
        <#code#>
    }
    
    func makeUsersDetailsViewController(user: User) -> UIViewController {
        <#code#>
    }
    
    func makeUsersQueriesSuggestionsListViewController(didSelect: @escaping UsersQueryListViewModelDidSelectAction) -> UIViewController {
        <#code#>
    }
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
        let imageDataTransferService: DataTransferService
    }
    
    
    private let dependencies: Dependencies
    
    // MARK: - Persistent Storage
    lazy var usersQueriesStorage: UsersQueriesStorage = CoreDataUsersQueriesStorage(maxStorageLimit: 10)
    lazy var userResponseCache: UsersResponseStorage = CoreDataUsersResponseStorage()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Use Cases
    func makeSearchUsersUseCase() -> SearchUsersUseCase {
        DefaultSearchUsersUseCase(
            usersRepositories: makeUsersRepository(),
            usersQueriesRepositories: makeUsersQueriesRepository()
        )
    }
    
    func makeFetchRecentUserQueriesUseCase(
        requestValue: FetchRecentUserQueriesUseCase.RequestValue,
        completion: @escaping (FetchRecentUserQueriesUseCase.ResultValue) -> Void
    ) -> FetchRecentUserQueriesUseCase {
        FetchRecentUserQueriesUseCase(
            requestValue: requestValue, completion: completion, userQueriesRepository: makeUsersQueriesRepository()
        )
    }
    
    
    // MARK: - Repositories
    func makeUsersRepository() -> UsersRepository {
        DefaultUsersRepository(
            dataTransferService: dependencies.apiDataTransferService,
            cache: userResponseCache
        )
    }
    func makeUsersQueriesRepository() -> UsersQueriesRepository {
        DefaultUsersQueriesRepository(
            usersQueriesPersistentStorage: usersQueriesStorage
        )
    }
    func makeProfileImagesRepository() -> ProfileImagesRepository {
        DefaultProfileImagesRepository(
            dataTransferService: dependencies.imageDataTransferService
        )
    }
    
    // MARK: - Movies List
    func makeUsersListViewController(actions: UsersListViewModelActions) -> UsersListViewController {
        UsersListViewController.create(
            with: makeUsersListViewModel(actions: actions),
            profileImagesRepository: makeProfileImagesRepository()
        )
    }
    
    func makeUsersListViewModel(actions: UsersListViewModelActions) -> UsersListViewModel {
        DefaultUsersListViewModel(
            searchUsersUseCase: makeSearchUsersUseCase(),
            actions: actions
        )
    }
}
