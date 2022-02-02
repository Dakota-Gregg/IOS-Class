//
//  NasaPhotos.swift
//  Homework2
//
//  Created by Consultant on 2/1/22.
//

import Foundation

struct Nasa : Codable{
    let photos: [NasaPhotos]
    struct NasaPhotos : Codable{
        let id : Int
        let sol : Int
        let camera :  Camera
        struct Camera : Codable{
            let id : Int
            let name : String
            let rover_id : Int
            let full_name : String
        }
        let img_src : String
        let earth_date : String
    }
}
