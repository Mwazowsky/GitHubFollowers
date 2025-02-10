//
//  UsersListViewController.swift
//  UIkitZeroToHero
//
//  Created by MacBook Air MII  on 07/02/25.
//

import UIKit

class UsersListViewController: UIViewController {
    
    private(set) var suggestionsListContainer: UIView!
    
    private var viewModel: UsersListViewModel!
    private var profileImagesRepository: ProfileImagesRepository?

    private var usersTableViewController: UsersListTableViewController?
    private var searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - LifeCycle
    static func create(
        with viewModel: UsersListViewModel,
        profileImageRepository: ProfileImagesRepository?
    ) -> UsersListViewController {
        let view = UsersListViewController()
        view.viewModel = viewModel
        view.profileImagesRepository = profileImageRepository
        
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
