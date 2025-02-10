//
//  UsersListTableViewController.swift
//  UIkitZeroToHero
//
//  Created by Saifulloh Fadli on 07/02/25.
//

import UIKit

class UsersListTableViewController: UITableViewController {
    
    var viewModel: UsersListViewModel!
    
    var profileImagesRepository: ProfileImagesRepository?
    var nextPageLoadingSpinner: UIActivityIndicatorView?
    
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    
    func reload() {
        tableView.reloadData()
    }
    
    
    func updateLoading(_ loading: UsersListViewModelLoading?) {
        switch loading {
        case .nextPage:
            nextPageLoadingSpinner?.removeFromSuperview()
            nextPageLoadingSpinner = makeActivityIndicator(size: .init(width: tableView.frame.width, height: 44))
            tableView.tableFooterView = nextPageLoadingSpinner
        case .fullScreen, .none:
            tableView.tableFooterView = nil
        }
    }
    
    // MARK: - Private
    func setupView() {
        tableView.estimatedRowHeight = UsersListItemCell.height
        tableView.rowHeight = UITableView.automaticDimension
    }
}


extension UsersListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: UsersListItemCell.reuseIdentifier,
            for: indexPath
        ) as? UsersListItemCell else {
            assertionFailure("Cannot dequeue reusable cell \(UsersListItemCell.self) with reuseIdentifier: \(UsersListItemCell.reuseIdentifier)")
            return UITableViewCell()
        }

        cell.fill(with: viewModel.items.value[indexPath.row],
                  profileImagesRepository: profileImagesRepository)

        if indexPath.row == viewModel.items.value.count - 1 {
            viewModel.didLoadNextPage()
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.isEmpty ? tableView.frame.height : super.tableView(tableView, heightForRowAt: indexPath)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.row)
    }
}
