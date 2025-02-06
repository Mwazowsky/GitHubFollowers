//
//  AppFlowConfiguration.swift
//  UIkitZeroToHero
//
//  Created by Saifulloh Fadli on 06/02/25.
//

import UIKit

final class AppFlowConfiguration {
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(
        navigationController: UINavigationController,
        appDIContainer: AppDIContainer
    ) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        // In App Flow we can check if user needs to login, if yes we would run login flow
        let userSceneDIContainer = appDIContainer.makeUsersSceneDIContainer()
        
    }
}
