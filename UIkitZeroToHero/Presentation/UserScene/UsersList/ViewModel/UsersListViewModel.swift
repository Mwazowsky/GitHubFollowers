//
//  UsersListViewModel.swift
//  UIkitZeroToHero
//
//  Created by Saifulloh Fadli on 06/02/25.
//

import Foundation

struct UsersListViewModelActions {
    /// Note: if you would need to edit user inside Details screen and update this Users List screen with updated user then you would need this closure:
    /// showUserDetails: (User, @escaping (_ updated: User) -> Void) -> Void
    let showUserDetails: (User) -> Void
    let showUserQueriesSuggestions: (@escaping (_ didSelect: UserQuery) -> Void) -> Void
    let closeUserQueriesSuggestions: () -> Void
}

enum UsersListViewModelLoading {
    case fullScreen
    case nextPage
}

protocol UsersListViewModelInput {
    func viewDidLoad()
    func didLoadNextPage()
    func didSearch(query: String)
    func didCancelSearch()
    func showQueriesSuggestions()
    func closeQueriesSuggestions()
    func didSelectItem(at index: Int)
}

protocol UsersListViewModelOutput {
    var items: Observable<[UsersListItemViewModel]> { get } /// Also we can calculate view model items on demand:  https://github.com/kudoleh/iOS-Clean-Architecture-MVVM/pull/10/files
    var loading: Observable<UsersListViewModelLoading?> { get }
    var query: Observable<String> { get }
    var error: Observable<String> { get }
    var isEmpty: Bool { get }
    var screenTitle: String { get }
    var emptyDataTitle: String { get }
    var errorTitle: String { get }
    var searchBarPlaceholder: String { get }
}

typealias UsersListViewModel = UsersListViewModelInput & UsersListViewModelOutput

final class DefaultUsersListViewModel: UsersListViewModel {
    private let searchUsersUseCase: SearchUsersUseCase
    private let actions: UsersListViewModelActions
    
    // MARK: - OUTPUT

    let items: Observable<[UsersListItemViewModel]> = Observable([])
    let loading: Observable<UsersListViewModelLoading?> = Observable(.none)
    let query: Observable<String> = Observable("")
    let error: Observable<String> = Observable("")
    var isEmpty: Bool { return items.value.isEmpty }
    let screenTitle = NSLocalizedString("Movies", comment: "")
    let emptyDataTitle = NSLocalizedString("Search results", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")
    let searchBarPlaceholder = NSLocalizedString("Search Movies", comment: "")
    
    // MARK: Init
    init(
        searchUsersUseCase: SearchUsersUseCase,
        actions: UsersListViewModelActions? = nil,
        mainQueue: DispatchQueueType = DispatchQueue.main
    ) {
        self.searchUsersUseCase = searchUsersUseCase
        self.actions = actions
        self.mainQueue = mainQueue
    }
    
    
}


extension DefaultUsersListViewModel {
    func viewDidLoad() {
        <#code#>
    }
    
    func didLoadNextPage() {
        <#code#>
    }
    
    func didSearch(query: String) {
        <#code#>
    }
    
    func didCancelSearch() {
        <#code#>
    }
    
    func showQueriesSuggestions() {
        <#code#>
    }
    
    func closeQueriesSuggestions() {
        <#code#>
    }
    
    func didSelectItem(at index: Int) {
        <#code#>
    }
}
