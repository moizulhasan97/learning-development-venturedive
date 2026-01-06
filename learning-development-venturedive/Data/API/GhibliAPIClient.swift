//
//  GhibliAPIClient.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 18/12/2025.
//

import Foundation

struct GhibliAPIClient {
    let baseURL = URL(string: "https://ghibliapi.vercel.app")!

    func get(path: String) async throws -> Data {
        guard let url = URL(string: path, relativeTo: baseURL) else {
            throw APIError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let http = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            guard (200..<300).contains(http.statusCode) else {
                throw APIError.httpError(statusCode: http.statusCode)
            }
            return data
        } catch let error as NSError where error.domain == "" {
            throw error
        } catch {
            throw APIError.network(error)
        }
    }
}
