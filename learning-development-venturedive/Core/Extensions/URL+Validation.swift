//
//  URL+Validation.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 06/01/2026.
//

import Foundation

/// A helper extension to validate URL schemes.
public extension URL {
    /// A Boolean value indicating whether the URL uses the HTTP or HTTPS scheme.
    var isHTTPURL: Bool {
        scheme == "http" || scheme == "https"
    }
}
