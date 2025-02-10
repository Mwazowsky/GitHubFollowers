//
//  String+Extension.swift
//  UIkitZeroToHero
//
//  Created by Saifulloh Fadli on 05/02/25.
//

import Foundation
import UIKit

extension UIViewController {
    func add(child: UIViewController, container: UIView) {
        addChild(child)
        child.view.frame = container.bounds
        container.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    
    func remove() {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}
