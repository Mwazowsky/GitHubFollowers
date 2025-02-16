//
//  UserQueryListView.swift
//  UIkitZeroToHero
//
//  Created by Saifulloh Fadli on 16/02/25.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
extension UsersQueryListItemViewModel: Identifiable { }

@available(iOS 13.0, *)
struct UsersQueryListView: View {
    @ObservedObject var viewModelWrapper: UsersQueryListViewModelWrapper
    
    var body: some View {
        List(viewModelWrapper.items) { item in
            Button(action: {
                self.viewModelWrapper.viewModel?.didSelect(item: item)
            }) {
                Text(item.query)
            }
        }
        .onAppear {
            self.viewModelWrapper.viewModel?.viewWillAppear()
        }
    }
}

@available(iOS 13.0, *)
final class UsersQueryListViewModelWrapper: ObservableObject {
    var viewModel: UsersQueryListViewModel?
    @Published var items: [UsersQueryListItemViewModel] = []
    
    init(viewModel: UsersQueryListViewModel?) {
        self.viewModel = viewModel
        viewModel?.items.observe(on: self) { [weak self] values in self?.items = values }
    }
}

#if DEBUG
@available(iOS 13.0, *)
struct MoviesQueryListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersQueryListView(viewModelWrapper: previewViewModelWrapper)
    }
    
    static var previewViewModelWrapper: UsersQueryListViewModelWrapper = {
        var viewModel = UsersQueryListViewModelWrapper(viewModel: nil)
        viewModel.items = [UsersQueryListItemViewModel(query: "item 1"),
                           UsersQueryListItemViewModel(query: "item 2")
        ]
        return viewModel
    }()
}
#endif
