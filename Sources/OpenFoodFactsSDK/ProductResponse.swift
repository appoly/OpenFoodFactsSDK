//
//  ProductResponse.swift
//  
//
//  Created by James Wolfe on 03/02/2023.
//



import SwiftUI



public struct ProductResponse: Codable, Identifiable {
    
    // MARK: - Variables
    
    public let barcode: String
    public let allergens: [Allergen]
    public let brands: [String]
    public let categories: [String]
    public let genericName: String
    public let productName: String
    public let quantity: String
    public let ingredients: String
    public let nutriments: NutrimentsResponse
    public let analysisTags: [AnalysisTag]
    public let ingredientsVerified: Bool
    
    public var id: String { return barcode }
    
    
    
    // MARK: - Coding Keys
    
    private enum ParentKeys: String, CodingKey {
        case code
        case product
    }
    
    
    enum CodingKeys: String, CodingKey {
        case allergens = "allergens_tags"
        case brands = "brands_tags"
        case categories = "categories_tags"
        case genericName = "generic_name_en"
        case productName = "product_name_en"
        case quantity
        case ingredients = "ingredients_text_en"
        case nutriments
        case analysisTags = "ingredients_analysis_tags"
        case states
        case ingredientsVerified = "ingredients_verified"
    }
    
    
    
    // MARK: - Initializers
    
    public init(from decoder: Decoder) throws {
        let parent = try decoder.container(keyedBy: ParentKeys.self)
        barcode = try parent.decode(String.self, forKey: .code)
        let container = try parent.nestedContainer(keyedBy: CodingKeys.self, forKey: .product)
        
        allergens = try container.decode([Allergen].self, forKey: .allergens)
        brands = try container.decode([String].self, forKey: .brands).map { $0.split(separator: "_").joined(separator: " ").capitalized }
        categories = try container.decode([String].self, forKey: .categories).map { $0.split(separator: "_").joined(separator: " ").capitalized }
        genericName = try container.decode(String.self, forKey: .genericName)
        productName = try container.decode(String.self, forKey: .productName)
        quantity = try container.decode(String.self, forKey: .quantity)
        ingredients = try container.decode(String.self, forKey: .ingredients)
        nutriments = try container.decode(NutrimentsResponse.self, forKey: .nutriments)
        analysisTags = try container.decode([AnalysisTag].self, forKey: .analysisTags)
        ingredientsVerified = !(try container.decode(String.self, forKey: .states).contains("en:ingredients-to-be-completed"))
    }
    
    
    
    // MARK: - Encodable
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(allergens, forKey: .allergens)
        try container.encode(brands, forKey: .brands)
        try container.encode(categories, forKey: .categories)
        try container.encode(genericName, forKey: .genericName)
        try container.encode(productName, forKey: .productName)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(ingredients, forKey: .ingredients)
        try container.encode(nutriments, forKey: .nutriments)
        try container.encode(analysisTags, forKey: .analysisTags)
        try container.encode(ingredientsVerified, forKey: .ingredientsVerified)
    }
    
    
    
    // MARK: - Utilities
    
    public func safe(forDiet diet: Diet) -> SafetyStatus {
        guard ingredientsVerified else { return .unknown }
        switch diet {
            case .vegetarian:
                return (analysisTags.contains(.vegetarian) || analysisTags.contains(.vegan)) ? .safe : .unsafe
        case .vegan:
            return analysisTags.contains(.vegan) ? .safe: .unsafe
        }
    }
    
    
    public func safe(forAllergies alleries: [Allergen]) -> SafetyStatus {
        guard ingredientsVerified else { return .unknown }
        let product = Set(self.allergens)
        let user = Set(alleries)
        return product.intersection(user).count == 0 ? .safe : .unsafe
    }
    
}
