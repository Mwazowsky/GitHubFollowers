//
//  AppConfiguration.swift
//  UIkitZeroToHero
//
//  Created by Saifulloh Fadli on 06/02/25.
//

import Foundation

final class AppConfiguration {
    lazy var apiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String else {
            fatalError("ApiKey not found in Info.plist")
        }
        
        return apiKey
    } ()
    
    
    lazy var apiBaseURL: String = {
        guard let apiBaseUrl = Bundle.main.object(forInfoDictionaryKey: "ApiBaseUrl") as? String else {
            fatalError("ApiBaseUrl not found in Info.plist")
        }
        
        return apiBaseUrl
    } ()
    
    
    lazy var imagesBaseURL: String = {
        guard let imageBaseUrl = Bundle.main.object(forInfoDictionaryKey: "ImageBaseUrl") as? String else {
            fatalError("ImageBaseUrl not found in Info.plist")
        }
        
        return imageBaseUrl
    } ()
}
