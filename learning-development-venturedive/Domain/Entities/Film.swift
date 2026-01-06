//
//  Film.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 18/12/2025.
//

import Foundation

public struct Film: Identifiable, Equatable, Sendable {
    public let id: String
    public let title: String
    public let originalTitle: String
    public let description: String
    public let director: String
    public let producer: String
    public let releaseDate: String
    public let runningTime: String
    public let rtScore: String
    public let movieBannerURL: URL?
    public let url: URL?

    public init(id: String, title: String, originalTitle: String, description: String, director: String, producer: String, releaseDate: String, runningTime: String, rtScore: String, movieBannerURL: URL?, url: URL?) {
        self.id = id
        self.title = title
        self.originalTitle = originalTitle
        self.description = description
        self.director = director
        self.producer = producer
        self.releaseDate = releaseDate
        self.runningTime = runningTime
        self.rtScore = rtScore
        self.movieBannerURL = movieBannerURL
        self.url = url
    }
}
