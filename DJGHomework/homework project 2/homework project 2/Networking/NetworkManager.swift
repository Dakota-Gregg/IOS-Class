//
//  NetworkManager.swift
//  homework project 2
//
//  Created by Consultant on 2/16/22.
//

import Foundation
import Alamofire

class NetworkManager{
    func getModel<Model: Codable>(_ type: Model.Type, from url: String, completion: @escaping (Result<Model, NetworkError>) -> ()) {
           print("URL IS  \(url)")
           guard let url = URL(string: url) else {
               completion(.failure(.badURL))
               return
           }
           
           AF.request(url).responseData { response in
               if let data = response.data {
                   do {
                       let response = try JSONDecoder().decode(type, from: data)
                       completion(.success(response))
                       print(response)
                   } catch let error {
                       completion(.failure(.other(error)))
                       print("URLfailure")
                   }
               }
           }
           .resume()
       }
    func getImageData(from url: String, completion: @escaping (Data?) -> Void) {
            guard let url = URL(string: url) else {
                completion(nil)
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                completion(data)
            }
            .resume()
        }
}

