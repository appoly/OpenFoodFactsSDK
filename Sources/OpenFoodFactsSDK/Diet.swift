//
//  File.swift
//  
//
//  Created by James Wolfe on 04/02/2023.
//



import SwiftUI



public enum Diet: String, Codable, Identifiable, Hashable, CaseIterable {
    
    // MARK: - Cases
    
    case vegan
    case vegetarian
    
    
    
    // MARK: - Variables
    
    public var id: String { return rawValue }
    
    public var name: String {
        switch self {
            case .vegan:
                return "Vegan"
            case .vegetarian:
                return "Vegetarian"
        }
    }
    
    
    public var image: Image {
        switch self {
            case .vegan:
                return .init("vegan", bundle: .module)
            case .vegetarian:
                return .init("vegetarian", bundle: .module)
        }
    }
    
}

