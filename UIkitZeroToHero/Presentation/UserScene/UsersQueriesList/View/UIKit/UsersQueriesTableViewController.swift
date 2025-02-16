//
//  UsersQueriesTableViewController.swift
//  UIkitZeroToHero
//
//  Created by Saifulloh Fadli on 16/02/25.
//

import UIKit

class UsersQueriesTableViewController: UITableViewController, StoryboardInstantiable {
    private var viewModel: UsersQueryListViewModel!

    // MARK: - LIfecycle
    static func create(with viewModel: UsersQueryListViewModel) -> UsersQueriesTableViewController {
        let view = UsersQueriesTableViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Private
    private func setupView() {
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = UsersQueriesItemCell.height
        tableView.rowHeight = UITableView.automaticDimension
    }
}


extension UsersQueriesTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersQueriesItemCell.reuseIdentifier, for: indexPath) as? UsersQueriesItemCell else {
            assertionFailure("Cannot dequeue reusable cell \(UsersQueriesItemCell.self) with reuseIdentifier: \(UsersQueriesItemCell.reuseIdentifier)")
            return UITableViewCell()
        }
        cell.fill(with: viewModel.items.value[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        viewModel.didSelect(item: viewModel.items.value[indexPath.row])
    }
}
