//
//  File.swift
//  
//
//  Created by James Wolfe on 04/02/2023.
//



import Foundation



public enum AnalysisTag: String, Codable, Identifiable, Hashable, CaseIterable {
    
    // MARK: - Cases
    
    case vegetarianStatusUnknown = "en:vegetarian-status-unknown"
    case mayContainPalmOil = "en:may-contain-palm-oil"
    case containsPalmOil = "en:palm-oil"
    case nonVegan = "en:non-vegan"
    case vegan = "en:vegan"
    case palmOilContentUnknown = "en:palm-oil-content-unknown"
    case veganStatusUnknown = "en:vegan-status-unknown"
    case palmOilFree = "en:palm-oil-free"
    case vegetarian = "en:vegetarian"
    case nonVegetarian = "en:non-vegetarian"
    case maybeVegan = "en:maybe-vegan"
    case maybeVegetarian = "en:maybe-vegetarian"
    
    
    
    // MARK: - Variables
    
    var id: String { return rawValue }
    
    public var name: String {
        switch self {
            case .vegetarianStatusUnknown:
                return "Vegetarian Status Unknown"
            case .mayContainPalmOil:
                return "May Contain Palm Oil"
            case .containsPalmOil:
                return "Contains Palm Oil"
            case .nonVegan:
                return "Not Suitable For Vegans"
            case .vegan:
                return "Suitable For Vegans"
            case .palmOilContentUnknown:
                return "Palm Oil Contents Unknown"
            case .veganStatusUnknown:
                return "Vegan Status Unknown"
            case .palmOilFree:
                return "Does Not Cotain Palm Oil"
            case .vegetarian:
                return "Suitable for Vegetarians"
            case .nonVegetarian:
                return "Not Suitable for Vegetarians"
            case .maybeVegan:
                return "May Be Suitable For Vegans"
            case .maybeVegetarian:
                return "May Be Suitable For Vegetarians"
        }
    }
    
}
