//
//  File.swift
//  
//
//  Created by James Wolfe on 05/02/2023.
//



import Foundation



public enum SafetyStatus: String, Codable, Identifiable, Hashable, CaseIterable {
    
    // MARK: - Cases
    
    case safe
    case unsafe
    case unknown
    
    
    
    // MARK: - Variables
    
    public var id: String { return rawValue }
    
}
