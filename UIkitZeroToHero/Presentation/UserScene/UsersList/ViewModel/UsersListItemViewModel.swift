//
//  UsersListItemViewModel.swift
//  UIkitZeroToHero
//
//  Created by Saifulloh Fadli on 06/02/25.
//

// **Note**: This item view model is to display data and does not contain any domain model to prevent views accessing it

import Foundation

struct UsersListItemViewModel: Equatable {
    let name: String
    let email: String
}

extension UsersListItemViewModel {
    init (user: User) {
        self.name = user.name
        self.email = user.email
    }
}

// Misc
private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
