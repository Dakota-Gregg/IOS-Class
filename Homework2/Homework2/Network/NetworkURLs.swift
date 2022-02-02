//
//  NetworkURLs.swift
//  Homework2
//
//  Created by Consultant on 2/1/22.
//

import Foundation

enum NetworkURLs {
    
    static let baseURL = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?api_key=Q9YNbzmt8C5OpY7L3MV4DHJhrdIGCbjx3tVWxRcf&sol=2000&page=1"
    
    static let photoURL = "\(baseURL)/photos"
}
