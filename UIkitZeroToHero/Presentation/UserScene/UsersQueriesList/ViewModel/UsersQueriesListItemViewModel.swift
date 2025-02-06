//
//  UsersListViewModel.swift
//  UIkitZeroToHero
//
//  Created by Saifulloh Fadli on 06/02/25.
//

import Foundation

class UsersQueriesListItemViewModel {
    let name: String
    let avatarUrl: URL
    
    init(name: String, avatarUrl: URL) {
        self.name = name
        self.avatarUrl = avatarUrl
    }
}
