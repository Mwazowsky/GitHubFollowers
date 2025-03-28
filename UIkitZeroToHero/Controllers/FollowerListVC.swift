//
//  FollowerListVC.swift
//  UIkitZeroToHero
//
//  Created by Saifulloh Fadli on 04/02/25.
//

import UIKit

@available(iOS 13.0, *)
class FollowerListVC: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor                                    = .systemBackground
        navigationController?.isNavigationBarHidden             = false
        navigationController?.navigationBar.prefersLargeTitles  = true
    }

}
