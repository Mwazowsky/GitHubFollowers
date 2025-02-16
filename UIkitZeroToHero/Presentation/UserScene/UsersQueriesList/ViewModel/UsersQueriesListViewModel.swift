//
//  UsersListItemViewModel.swift
//  UIkitZeroToHero
//
//  Created by Saifulloh Fadli on 06/02/25.
//

import Foundation

typealias UsersQueryListViewModelDidSelectAction = (UserQuery) -> Void

protocol UsersQueryListViewModelInput {
    func viewWillAppear()
    func didSelect(item: UsersQueryListItemViewModel)
}


protocol UsersQueryListViewModelOutput {
    var items: Observable<[UsersQueryListItemViewModel]> { get }
}


protocol UsersQueryListViewModel: UsersQueryListViewModelInput, UsersQueryListViewModelOutput { }


typealias FetchRecentUserQueriesUseCaseFactory = (
    FetchRecentUserQueriesUseCase.RequestValue,
    @escaping (FetchRecentUserQueriesUseCase.ResultValue) -> Void
) -> UseCase


final class DefaultUsersQueryListViewModel: UsersQueryListViewModel {
    private let numberOfQueriesToShow: Int
    private let fetchRecentUserQueriesUseCaseFactory: FetchRecentUserQueriesUseCaseFactory
    private let didSelect: UsersQueryListViewModelDidSelectAction?
    private let mainQueue: DispatchQueueType
    
    // MARK: - OUTPUT
    let items: Observable<[UsersQueryListItemViewModel]> = Observable([])
    
    init(
        numberOfQueriesToShow: Int,
        fetchRecentUserQueriesUseCaseFactory: @escaping FetchRecentUserQueriesUseCaseFactory,
        didSelect: UsersQueryListViewModelDidSelectAction? = nil,
        mainQueue: DispatchQueueType = DispatchQueue.main
    ) {
        self.numberOfQueriesToShow = numberOfQueriesToShow
        self.fetchRecentUserQueriesUseCaseFactory = fetchRecentUserQueriesUseCaseFactory
        self.didSelect = didSelect
        self.mainQueue = mainQueue
    }
    
    private func updateUsersQueries() {
        let request = FetchRecentUserQueriesUseCase.RequestValue(maxCount: numberOfQueriesToShow)
        let completion: (FetchRecentUserQueriesUseCase.ResultValue) -> Void = { [weak self] result in
            self?.mainQueue.async {
                switch result {
                case .success(let items):
                    self?.items.value = items
                        .map { $0.query }
                        .map(UsersQueryListItemViewModel.init)
                case .failure:
                    break
                }
            }
        }
        let useCase = fetchRecentUserQueriesUseCaseFactory(request, completion)
        useCase.start()
    }
}

// MARK: - INPUT. View event methods
extension DefaultUsersQueryListViewModel {
        
    func viewWillAppear() {
        updateUsersQueries()
    }
    
    func didSelect(item: UsersQueryListItemViewModel) {
        didSelect?(UserQuery(query: item.query))
    }
}
