//
//  NetworkError.swift
//  homework project 2
//
//  Created by Consultant on 2/16/22.
//

import Foundation
enum NetworkError: Error, LocalizedError {
    case badURL
    case other(Error)
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "Bad url"
        case .other(let error):
            return error.localizedDescription
        }
    }
}
