//
//  UsersResponseStorage.swift
//  UIkitZeroToHero
//
//  Created by MacBook Air MII  on 07/02/25.
//

import Foundation

protocol UsersResponseStorage {
    func getResponse(
        for request: UsersRequestDTO,
        completion: @escaping (Result<UsersResponseDTO?, Error>) -> Void
    ) 
    
    func save(response: UsersResponseDTO, for requestDto: UsersRequestDTO)
}
