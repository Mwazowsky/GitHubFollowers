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
