//
//  UserSearchFlowCoordinator.swift
//  UIkitZeroToHero
//
//  Created by Saifulloh Fadli on 06/02/25.
//

import Foundation
import UIKit

protocol UsersSearchFlowCoordinatorDependencies  {
    func makeUserssListViewController(
        actions: UsersListViewModelActions
    ) -> UsersListViewController
    func makeUsersDetailsViewController(user: User) -> UIViewController
    func makeUsersQueriesSuggestionsListViewController(
        didSelect: @escaping UsersQueryListViewModelDidSelectAction
    ) -> UIViewController
}


final class UsersSearchFlowCoordinator {
    private weak var navigatioController: UINavigationController?
    private let dependencies: UsersSearchFlowCoordinatorDependencies
    
    private weak var usersListVC: UsersListViewController?
    private weak var usersQueriesSuggestionsVC: UIViewController?
    
    init(
        navigatioController: UINavigationController? = nil,
        dependencies: UsersSearchFlowCoordinatorDependencies,
        usersListVC: UsersListViewController? = nil,
        usersQueriesSuggestionsVC: UIViewController? = nil
    ) {
        self.navigatioController = navigatioController
        self.dependencies = dependencies
        self.usersListVC = usersListVC
        self.usersQueriesSuggestionsVC = usersQueriesSuggestionsVC
    }
    
    
    func start() {
        // Note: here we keep strong reference with actions, this way this flow do not need to be strong referenced
        let actions = UsersListViewModelActions(
            showUserDetails: showUserDetails,
            showUserQueriesSuggestions: showUserQueriesSuggestions,
            closeUserQueriesSuggestions: closeUserQueriesSuggestion)
        
        let vc = dependencies.makeUserssListViewController(actions: actions)
        
        navigatioController?.pushViewController(vc, animated: false)
        usersListVC = vc
    }
    
    
    private func showUserDetails(user: User) {
        let vc = dependencies.makeUsersDetailsViewController(user: user)
        navigatioController?.pushViewController(vc, animated: true)
    }
    
    
    private func showUserQueriesSuggestions(didSelect: @escaping (UserQuery) -> Void) {
        guard let usersListViewController = usersListVC, usersQueriesSuggestionsVC == nil, let container = usersListViewController.suggestionsListContainer else { return }
        
        let vc = dependencies.makeUsersQueriesSuggestionsListViewController(didSelect: didSelect)
        
        usersListViewController.add(child: vc, container: container)
        usersQueriesSuggestionsVC = vc
        container.isHidden = false
    }
    
    
    private func closeUserQueriesSuggestion() {
        usersQueriesSuggestionsVC?.remove()
        usersQueriesSuggestionsVC = nil
        usersListVC?.suggestionsListContainer.isHidden = true
    }
}
