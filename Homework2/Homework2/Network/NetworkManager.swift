//
//  NetworkManager.swift
//  Homework2
//
//  Created by Consultant on 2/1/22.
//

import Foundation

    class NetworkManager{

    func getPhotos(from url : String, completion : @escaping (Result <Nasa, NetworkError>) ->Void){
        guard let url = URL(string: url)
        else{
            completion(Result.failure (NetworkError.badURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, Response, error in
            if let error = error {
                completion(.failure(.other(error)))
                return
            }
            if let data = data {
                do{
                    let response = try JSONDecoder().decode(Nasa.self, from: data)
                    completion(.success(response))
                }
                catch let error {
                    completion(.failure(.other(error)))
                }
            }
        }
        .resume()
    }
}
