//
//  APIEndpoints.swift
//  UIkitZeroToHero
//
//  Created by MacBook Air MII  on 07/02/25.
//

import Foundation

struct APIEndpoints {
    
    static func getUsers(with usersRequestDTO: UsersRequestDTO) -> Endpoint<UsersResponseDTO> {
        
        return Endpoint(
            path: "3/search/movie",
            method: .get,
            queryParametersEncodable: usersRequestDTO
        )
    }
    
    static func getProfileImage(path: String, width: Int) -> Endpoint<Data> {
        
        let sizes = [92, 154, 185, 342, 500, 780]
        let closestWidth = sizes
            .enumerated()
            .min { abs($0.1 - width) < abs($1.1 - width) }?
            .element ?? sizes.first!
        
        return Endpoint(
            path: "t/p/w\(closestWidth)\(path)",
            method: .get,
            responseDecoder: RawDataResponseDecoder()
        )
    }
}

