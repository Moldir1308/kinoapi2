//
//  MoviesResult.swift
//  Api2
//
//  Created by Ualikhan Sabden on 05.11.2023.
//

import Foundation
// Model
struct MoviesResult: Codable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Results]
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
    }
    
}

struct Results: Codable {
    let posterPath: String?
    let id: Int
    let originLan: String?
    let title: String
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case originLan = "original_language"
    }
    
}
