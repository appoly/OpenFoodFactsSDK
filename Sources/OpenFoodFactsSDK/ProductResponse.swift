//
//  ProductResponse.swift
//  
//
//  Created by James Wolfe on 03/02/2023.
//



import SwiftUI



public struct ProductResponse: Codable {
    
    // MARK: - Variables
    
    let allergens: [Allergen]
    let brands: [String]
    let categories: [String]
    let genericName: String
    let productName: String
    let quantity: String
    let ingredients: String
    let nutriments: NutrimentsResponse
    
    
    
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
    }
    
    
    
    // MARK: - Initializers
    
    public init(from decoder: Decoder) throws {
        let parent = try decoder.container(keyedBy: ParentKeys.self)
        let container = try parent.nestedContainer(keyedBy: CodingKeys.self, forKey: .product)
        
        allergens = try container.decode([Allergen].self, forKey: .allergens)
        brands = try container.decode([String].self, forKey: .brands).map { $0.split(separator: "_").joined(separator: " ").capitalized }
        categories = try container.decode([String].self, forKey: .categories).map { $0.split(separator: "_").joined(separator: " ").capitalized }
        genericName = try container.decode(String.self, forKey: .genericName)
        productName = try container.decode(String.self, forKey: .productName)
        quantity = try container.decode(String.self, forKey: .quantity)
        ingredients = try container.decode(String.self, forKey: .ingredients)
        nutriments = try container.decode(NutrimentsResponse.self, forKey: .nutriments)
    }
    
}
