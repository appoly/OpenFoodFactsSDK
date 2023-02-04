//
//  ErrorResponse.swift
//  
//
//  Created by James Wolfe on 03/02/2023.
//



import Foundation



struct ErrorResponse: Codable {
    
    // MARK: - Variables
    
    let code: String
    let status: Int
    let statusVerbose: String
    
    
    
    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case code
        case status
        case statusVerbose = "status_verbose"
    }
    
}
