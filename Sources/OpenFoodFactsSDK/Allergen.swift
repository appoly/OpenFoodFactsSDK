//
//  Allergen.swift
//  
//
//  Created by James Wolfe on 03/02/2023.
//



import SwiftUI



public enum Allergen: String, Codable, Identifiable, Hashable, CaseIterable {
    
    // MARK: - Cases
    
    case crustaceans = "en:crustaceans"
    case peanuts = "en:peanuts"
    case nuts = "en:nuts"
    case mustard = "en:mustard"
    case lupin = "en:luping"
    case gluten = "en:gluten"
    case soyBeans = "en:soybeans"
    case celery = "en:celery"
    case sulphurDioxideAndSulphites = "en:sulphur-dioxide-and-sulphites"
    case fish = "en:fish"
    case molluscs = "en:molluscs"
    case milk = "en:milk"
    case eggs = "en:eggs"
    case sesameSeeds = "en:sesame-seeds"
    
    
    
    // MARK: - Variables
    
    public var id: String { return rawValue }
    
    public var name: String {
        switch self {
            case .crustaceans:
                return "Crustaceans"
            case .peanuts:
                return "Peanuts"
            case .nuts:
                return "Tree Nuts"
            case .mustard:
                return "Mustard"
            case .lupin:
                return "Lupin"
            case .gluten:
                return "Gluten"
            case .soyBeans:
                return "Soya"
            case .celery:
                return "Celery"
            case .sulphurDioxideAndSulphites:
                return "Sulphur Dioxide and Sulphites"
            case .fish:
                return "Fish"
            case .molluscs:
                return "Molluscs"
            case .milk:
                return "Milk"
            case .eggs:
                return "Eggs"
            case .sesameSeeds:
                return "Sesame"
        }
    }
    
    
    public var image: Image {
        switch self {
            case .crustaceans:
            return .init("crustaceans", bundle: .module)
            case .peanuts:
                return .init("peanut", bundle: .module)
            case .nuts:
                return .init("treenut", bundle: .module)
            case .mustard:
                return .init("mustard", bundle: .module)
            case .lupin:
                return .init("lupin", bundle: .module)
            case .gluten:
                return .init("wheat", bundle: .module)
            case .soyBeans:
                return .init("soya", bundle: .module)
            case .celery:
                return .init("celery", bundle: .module)
            case .sulphurDioxideAndSulphites:
                return .init("sulphurdioxide", bundle: .module)
            case .fish:
                return .init("fish", bundle: .module)
            case .molluscs:
                return .init("molluscs", bundle: .module)
            case .milk:
                return .init("milk", bundle: .module)
            case .eggs:
                return .init("eggs", bundle: .module)
            case .sesameSeeds:
                return .init("sesame", bundle: .module)
        }
    }
    
}

