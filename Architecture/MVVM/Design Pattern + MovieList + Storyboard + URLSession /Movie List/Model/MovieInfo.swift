//
//  MovieInfo.swift
//  Movie List
//

import Foundation
import UIKit

struct MovieInfo: Decodable {
    let results: [MovieResult]
}

struct MovieResult: Decodable {
    let id: Int?
    let posterPath: String?
    var posterUrl: URL?
    let title: String?
    let overview: String?
    var cellHeight: CGFloat?
    let price: Int?

    enum CodingKeys: String, CodingKey {
        case id, posterUrl, title, overview, cellHeight
        case posterPath = "poster_path"
        case price = "vote_count"
    }
}
