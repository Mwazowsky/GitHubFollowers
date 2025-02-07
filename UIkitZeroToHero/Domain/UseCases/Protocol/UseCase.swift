//
//  UseCase.swift
//  UIkitZeroToHero
//
//  Created by MacBook Air MII  on 07/02/25.
//

import Foundation

protocol UseCase {
    @discardableResult func start() -> Cancellable?
}
