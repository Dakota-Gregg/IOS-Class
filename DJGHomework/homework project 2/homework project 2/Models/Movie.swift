//
//  Movie.swift
//  homework project 2
//
//  Created by Consultant on 2/16/22.
//

import Foundation

struct movie: Codable{
    let id: Int
    let originalTitle: String
    let overview: String
    let posterPath: String
    let productionCompanies: [company]?
    var isFav: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, overview
        case posterPath = "poster_path"
        case originalTitle = "original_title"
        case productionCompanies = "production_companies"
    }
    init(id: Int, posterPath: String, originalTitle: String, overview: String, isFav: Bool){
        self.id = id
        self.overview = overview
        self.posterPath = posterPath
        self.originalTitle = originalTitle
        self.productionCompanies = nil
        self.isFav = isFav
    }
}
//struct productionCompanies: Codable{
//    let production_companies: [company]
//}

