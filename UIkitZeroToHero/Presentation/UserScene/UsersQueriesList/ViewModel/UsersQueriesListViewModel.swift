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
    func didSelect(item: UsersQueriesListItemViewModel)
}


protocol UsersQueryListViewModelOutput {
    var items: Observable<[UsersQueriesListItemViewModel]> { get }
}


protocol UsersQueryListViewModel: UsersQueryListViewModelInput, UsersListViewModelOutput { }


typealias FetchRecentUsrQueriesUseCaseFactory = (
    FetchRecentUsrQueriesUseCase.RequestValue,
    @escaping (FetchRecentUsrQueriesUseCase.ResutValue) -> Void
) -> UseCase


class UsersQueriesListViewModel {
    
}
