//
//  FilmDTO.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 18/12/2025.
//

import Foundation

struct FilmDTO: Decodable {
    let id: String
    let title: String
    let original_title: String
    let description: String
    let director: String
    let producer: String
    let release_date: String
    let running_time: String
    let rt_score: String
    let url: String?
}

extension FilmDTO {
    func toDomain() -> Film {
        Film(
            id: id,
            title: title,
            originalTitle: original_title,
            description: description,
            director: director,
            producer: producer,
            releaseDate: release_date,
            runningTime: running_time,
            rtScore: rt_score,
            url: url.flatMap(URL.init(string:))
        )
    }
}
