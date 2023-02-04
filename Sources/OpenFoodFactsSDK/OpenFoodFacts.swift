


import Foundation



public struct OpenFoodFacts {
    
    // MARK: - Variables
    
    private let app: String
    private let version: String
    private let build: String
    private let website: URL?
    private let baseURL: URL = .init(string: "https://world.openfoodfacts.org/api/v2/")!
    
    private let session: URLSession = {
        var configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration)
    }()
    
    
    
    // MARK: - Initializers
    
    public init(app: String, version: String, build: String, website: URL? = nil) {
        self.app = app
        self.build = build
        self.version = version
        self.website = website
    }
    
    
    
    // MARK: - Actions
    
    public func getProduct(byBarcode barcode: String) async throws -> ProductResponse {
        let url = baseURL.appendingPathComponent("product/\(barcode)")
        guard let request: URLRequest = .init(app: app, version: version, build: build, website: website, url: url, method: .get) else { throw "Invalid Request Data" }
        return try await session.decodeRequest(request: request)
    }

}



extension URLSession {
    
    internal func decodeRequest<T: Decodable>(request: URLRequest, decoder: JSONDecoder = .init()) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: request) { data, response, error in
                do {
                    guard error == nil else { throw error! }
                    if let response = response as? HTTPURLResponse, !Array(200..<300).contains(response.statusCode) { throw "HTTP Error \(response.statusCode)" }
                    guard let data = data else { throw "Invalid Response Data" }
                    if let response = try? decoder.decode(T.self, from: data) {
                        continuation.resume(returning: response)
                    } else if let error = try? decoder.decode(ErrorResponse.self, from: data) {
                        throw error.statusVerbose.capitalized
                    } else {
                        throw "Invalid Response Data"
                    }
                } catch let error {
                    continuation.resume(throwing: error)
                }
            }.resume()
        }
    }
    
}



extension String: LocalizedError {
    
    public var errorDescription: String? { return self }
    
}



extension URLRequest {
    
    internal init?(app: String, version: String, build: String, website: URL?, url: URL, method: HTTPMethod, data: [String: String] = [:]) {
        
        let hasBody: (HTTPMethod) -> Bool = { [HTTPMethod.post, HTTPMethod.post].contains($0) }
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }
        components.queryItems = hasBody(method) ? nil : data.keys.map { URLQueryItem(name: $0, value: data[$0]) }
        guard let url = components.url else { return nil }
        
        self.init(url: url)
        self.httpMethod = method.rawValue
        
        if(hasBody(method)) {
            self.httpBody = try? JSONSerialization.data(withJSONObject: data)
        }
        
        let userAgent = website != nil ? "\(app) - iOS - Version \(version)(\(build)) - \(website!.absoluteString)" : "\(app) - iOS - Version \(version)(\(build))"
        setValue(userAgent, forHTTPHeaderField: "User-Agent")
    }
    
    
    
    internal enum HTTPMethod: String {
        
        // MARK: - Cases
        
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
        
    }
    
}
