//
//  UsersQueryListItemViewModel.swift
//  UIkitZeroToHero
//
//  Created by Saifulloh Fadli on 16/02/25.
//

import Foundation

class UsersQueryListItemViewModel {
    let query: String
    
    init(query: String) {
        self.query = query
    }
}


extension UsersQueryListItemViewModel: Equatable {
    static func == (lhs: UsersQueryListItemViewModel, rhs: UsersQueryListItemViewModel) -> Bool {
        return lhs.query == rhs.query
    }
}
