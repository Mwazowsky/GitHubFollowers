//
//  UIViewController+ActivityIndicator.swift
//  UIkitZeroToHero
//
//  Created by Saifulloh Fadli on 07/02/25.
//

import Foundation
import UIKit

extension UITableViewController {

    func makeActivityIndicator(size: CGSize) -> UIActivityIndicatorView {
        let style: UIActivityIndicatorView.Style
        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                style = UIActivityIndicatorView.Style.medium
            } else {
                style = UIActivityIndicatorView.Style.medium
            }
        } else {
            style = .gray
        }

        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        activityIndicator.frame = .init(origin: .zero, size: size)

        return activityIndicator
    }
}
