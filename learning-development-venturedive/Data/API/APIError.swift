//
//  APIError.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 18/12/2025.
//

import Foundation

struct APIError: Error {
    static let invalidURL = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
    static let invalidResponse = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
    static func httpError(statusCode: Int) -> NSError {
        NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP error with status code \(statusCode)"])
    }
    static func network(_ error: Error) -> NSError {
        NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
    }
}
