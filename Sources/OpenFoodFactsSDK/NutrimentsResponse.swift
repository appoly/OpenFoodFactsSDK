//
//  NutrimentsResponse.swift
//  
//
//  Created by James Wolfe on 03/02/2023.
//



import Foundation



public struct NutrimentsResponse: Codable {
    
    // MARK: - Variables
    
    let carbohydrates100G: Int
    let carbohydratesUnit: String
    let energyKcal100G: Int
    let energyKcalUnit: String
    let fat100G: Int
    let fatUnit: String
    let proteins100G: Double
    let proteinsUnit: String
    let salt100G: Double
    let saltUnit: String
    let saturatedFat100G: Double
    let saturatedFatUnit: String
    let sodium100G: Double
    let sodiumUnit: String
    let sugars100G: Double
    let sugarsUnit: String

    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case carbohydrates100G = "carbohydrates_100g"
        case carbohydratesUnit = "carbohydrates_unit"
        case energyKcal100G = "energy-kcal_100g"
        case energyKcalUnit = "energy-kcal_unit"
        case fat100G = "fat_100g"
        case fatUnit = "fat_unit"
        case proteins100G = "proteins_100g"
        case proteinsUnit = "proteins_unit"
        case salt100G = "salt_100g"
        case saltUnit = "salt_unit"
        case saturatedFat100G = "saturated-fat_100g"
        case saturatedFatUnit = "saturated-fat_unit"
        case sodium100G = "sodium_100g"
        case sodiumUnit = "sodium_unit"
        case sugars100G = "sugars_100g"
        case sugarsUnit = "sugars_unit"
    }
    
}
