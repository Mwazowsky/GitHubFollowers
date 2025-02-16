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
    
    // MARK: - Users List
    func makeUsersListViewController(actions: UsersListViewModelActions) -> UsersListViewController {
        UsersListViewController.create(
            with: makeUsersListViewModel(actions: actions),
            profileImageRepository: makeProfileImagesRepository()
        )
    }
    
    func makeUsersListViewModel(actions: UsersListViewModelActions) -> UsersListViewModel {
        DefaultUsersListViewModel(
            searchUsersUseCase: makeSearchUsersUseCase(),
            actions: actions
        )
    }
    
    // MARK: - Users Queries Suggestions List
    func makeUsersQueriesSuggestionsListViewController(didSelect: @escaping UsersQueryListViewModelDidSelectAction) -> UIViewController {
        if #available (iOS 13.0, *) {   // Swift UI
            let view = UsersQueryListView(
                viewModelWrapper: makeUsersQueryListViewModelWrapper(didSelect: didSelect)
            )
            return UIHostingController(rootView: view)
        } else {                        // UIKit
            return UsersQueriesTableViewController.create(
                with: makeUsersQueryListViewModel(didSelect: didSelect)
            )
        }
    }
    
    func makeUsersQueryListViewModel(didSelect: @escaping UsersQueryListViewModelDidSelectAction) -> UsersQueryListViewModel {
        DefaultUsersQueryListViewModel(
            numberOfQueriesToShow: 10,
            fetchRecentUserQueriesUseCaseFactory: makeFetchRecentUserQueriesUseCase,
            didSelect: didSelect
        )
    }
    
    @available(iOS 13.0, *)
    func makeUsersQueryListViewModelWrapper(
        didSelect: @escaping UsersQueryListViewModelDidSelectAction
    ) -> UsersQueryListViewModelWrapper {
        UsersQueryListViewModelWrapper(
            viewModel: makeUsersQueryListViewModel(didSelect: didSelect)
        )
    }
    
    // MARK: - Flow Cooordinator
    func makeUsersSearchFlowCoordinator(navigationController: UINavigationController) -> UsersSearchFlowCoordinator {
        UsersSearchFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
}
