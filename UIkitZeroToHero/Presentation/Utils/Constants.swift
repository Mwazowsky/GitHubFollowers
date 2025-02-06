//
//  Constants.swift
//  UIkitZeroToHero
//
//  Created by Saifulloh Fadli on 04/02/25.
//

import Foundation
import UIKit

struct AppConstants {
    static let appName = "UIkitZeroToHero"
    
    enum Environment {
        case development
        case production
    }
    
    struct API {
        static let baseURLString: String = "https://api.saranalintasmedika.co.id/api/v1"
        
        static var baseURL: URL {
            URL(string: baseURLString)!
        }
    }
    
    struct UserDefaults {
        static let tokenKey = "token"
    }
    
    struct Color {
        static let primary = UIColor.systemBlue
        static let secondary = UIColor.systemGray
    }
    
    struct Asset {
        static let logoImageName = "gh-logo"
    }
    
    struct font {
        static let regular = UIFont.systemFont(ofSize: 17, weight: .regular)
        static let headline = UIFont.preferredFont(forTextStyle: .headline)
    }
}
