


import XCTest
@testable import OpenFoodFactsSDK



final class OpenFoodFactsSDKTests: XCTestCase {
    
    // MARK: - Variables
    
    let sdk = OpenFoodFacts(app: "OpenFoodFactrsSwiftSDKUnityTests", version: "1.0.0", build: "1", website: .init(string: "https://www.appoly.co.uk"))
    
    
    
    // MARK: - Tests

    func testProductResponseDecoding() {
        let json = """
        {
            "code": "12345",
            "product": {
                "allergens_tags": ["en:crustaceans", "en:peanuts"],
                "brands_tags": ["brand_name_1", "brand_name_2"],
                "categories_tags": ["category_name_1", "category_name_2"],
                "generic_name_en": "Generic Name",
                "product_name_en": "Product Name",
                "quantity": "1kg",
                "ingredients_text_en": "Ingredients Text",
                "ingredients_analysis_tags": ["en:palm-oil-free", "en:maybe-vegan", "en:maybe-vegetarian"],
                "nutriments": {
                    "carbohydrates_100g": 1,
                    "carbohydrates_unit": "g",
                    "energy-kcal_100g": 2,
                    "energy-kcal_unit": "kcal",
                    "fat_100g": 3,
                    "fat_unit": "g",
                    "proteins_100g": 4,
                    "proteins_unit": "g",
                    "salt_100g": 5,
                    "salt_unit": "g",
                    "saturated-fat_100g": 6,
                    "saturated-fat_unit": "g",
                    "sodium_100g": 7,
                    "sodium_unit": "g",
                    "sugars_100g": 8,
                    "sugars_unit": "g"
                }
            }
        }
        """
        
        let data = json.data(using: .utf8)!
        
        do {
            let productResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
            
            XCTAssertEqual(productResponse.allergens, [.crustaceans, .peanuts])
            XCTAssertEqual(productResponse.brands, ["Brand Name 1", "Brand Name 2"])
            XCTAssertEqual(productResponse.categories, ["Category Name 1", "Category Name 2"])
            XCTAssertEqual(productResponse.genericName, "Generic Name")
            XCTAssertEqual(productResponse.productName, "Product Name")
            XCTAssertEqual(productResponse.quantity, "1kg")
            XCTAssertEqual(productResponse.ingredients, "Ingredients Text")
            XCTAssertEqual(productResponse.nutriments.carbohydrates100G, 1)
            XCTAssertEqual(productResponse.nutriments.carbohydratesUnit, "g")
            XCTAssertEqual(productResponse.nutriments.energyKcal100G, 2)
            XCTAssertEqual(productResponse.nutriments.energyKcalUnit, "kcal")
            XCTAssertEqual(productResponse.nutriments.fat100G, 3)
            XCTAssertEqual(productResponse.analysisTags, [.palmOilFree, .maybeVegan, .maybeVegetarian])
            XCTAssertEqual(productResponse.nutriments.fatUnit, "g")
            XCTAssertEqual(productResponse.nutriments.proteins100G, 4)
            XCTAssertEqual(productResponse.nutriments.proteinsUnit, "g")
            XCTAssertEqual(productResponse.nutriments.salt100G, 5)
            XCTAssertEqual(productResponse.nutriments.saltUnit, "g")
            XCTAssertEqual(productResponse.nutriments.saturatedFat100G, 6)
            XCTAssertEqual(productResponse.nutriments.saturatedFatUnit, "g")
            XCTAssertEqual(productResponse.nutriments.sodium100G, 7)
            XCTAssertEqual(productResponse.nutriments.sodiumUnit, "g")
            XCTAssertEqual(productResponse.nutriments.sugars100G, 8)
            XCTAssertEqual(productResponse.nutriments.sugarsUnit, "g")
        } catch {
            XCTFail("Failed to decode ProductResponse with error: \(error)")
        }
    }
    
    
    func testInvalidCode() async throws {
        do {
            let _ = try await sdk.getProduct(byBarcode: "1")
            XCTFail("Failed to throw error for invalid bar code")
        } catch let error {
            XCTAssertEqual(error.localizedDescription, "No Code Or Invalid Code")
        }
    }
    
    
    func testProductPerformance() async throws {
        let startTime = Date()
        
        do {
            let _ = try await sdk.getProduct(byBarcode: "5000128795562")
            let endTime = Date()
            let timeInterval = endTime.timeIntervalSince(startTime)
            XCTAssert(timeInterval < 1, "API call took too long to complete. Time interval: \(timeInterval) seconds")
        } catch let error {
            XCTFail("API call failed with error: \(error)")
        }
    }
    
}
