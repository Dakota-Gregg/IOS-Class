//
//  ViewModel.swift
//  homework project 2
//
//  Created by Consultant on 2/18/22.
//

import Foundation
import Combine
import UIKit
import CoreData
public class ViewModel{
    private var networkManager = NetworkManager()
    private var isLoading = false
    private var isLoading2 = false
    private var temp = ""
    @Published private (set) var favList = [movie]()
    @Published private (set) var movieSelected: movie?
    @Published private (set) var movieList = [movie]()
    @Published public var imageCache = [Int:Data]()
    @Published public var movieProductions = [Int:Any]()
    @Published private (set)var productionCompaniesCache = [company]()
    @Published private (set)var productionCompaniesLogoCache = [Int:Data]()
    public func getMovies(){
        loadMoreMovies()
      
    }
    private func getPoster(path: String ,movie: movie, completion: @escaping (Data) -> Void){
        if let data = imageCache[movie.id] {
                    completion(data)
                    return
                }
        networkManager.getImageData(from: "\(NetworkURLs.imageUrl)\(path)"){[weak self] data in
            if let data = data {
                DispatchQueue.main.async {
                    completion(data)
                }
                self?.imageCache[movie.id] = data
            }
        }
    }
    private func getLogo(path: String ,id: Int, completion: @escaping (Data) -> Void){
        if let data = productionCompaniesLogoCache[id] {
                    completion(data)
                    return
                }
        networkManager.getImageData(from: "\(NetworkURLs.imageUrl)\(path)"){[weak self] data in
            if let data = data {
                DispatchQueue.main.async {
                    completion(data)
                }
                self?.productionCompaniesLogoCache[id] = data
            }
        }
    }
    func getCompanyLogo(id: Int, logoPath: String, completion: @escaping (Data) -> Void){
        let posterPath = "\(NetworkURLs.imageUrl)\(logoPath)"
        getLogo(path: posterPath, id: id, completion: completion)
    }
    func getPoster(row: Int, completion: @escaping (Data) -> Void) {
            
            let movie = movieList[row]
            let posterPath = movie.posterPath
        getPoster(path: posterPath, movie: movie, completion: completion)
        }
    func getSinglePoster(selectedMovie: movie, completion: @escaping (Data) -> Void){
        let posterPath = selectedMovie.posterPath
        getPoster(path: posterPath, movie: selectedMovie, completion: completion)
    }
    func selectMovie(row: Int) {
        movieSelected = movieList[row]
    }
    func getCompanies(){
        let id = movieSelected?.id ?? 0
        let url = "\(NetworkURLs.productionPostersFirst)\(id)\(NetworkURLs.productionPostersLast)"
            networkManager.getModel(movie.self, from: url) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.movieSelected = response
                    self?.productionCompaniesCache = response.productionCompanies!
                case .failure(let error):
                    print(error)
                }
            }
    }

    func clearCompanies(){
        self.productionCompaniesLogoCache.removeAll()
        self.productionCompaniesCache.removeAll()
    }
    func getFavoriteMovies(){
        if UserDefaults.standard.object(forKey: "favList") != nil{
            self.favList = UserDefaults.standard.object(forKey: "favList") as! [movie]
        }
        else {
            return
        }
    }
    func favoriteMovie(favMovie: movie){
        var favorite = favMovie
        favorite.isFav = true
        for var i in self.movieList{
            if i.id == favMovie.id{
                i.isFav = true
                self.favList.append(favorite)
                if let data = try? JSONEncoder().encode(self.favList) {
                    UserDefaults.standard.set(data, forKey: "favList")
                }
                return
            }
        }
    }
    func unfavoriteMovie(favMovie: movie){
        var favorite = favMovie
        favorite.isFav = false
        for (i,var item) in movieList.enumerated(){
            if item.id == favMovie.id{
                item.isFav = false
                favList.remove(at: i)
                if let data = try? JSONEncoder().encode(favList) {
                             UserDefaults.standard.set(data, forKey: "favList")
                         }
                return
            }
        }
    }
    private func loadMoreMovies(){

        var newURL = NetworkURLs.baseurl
        if !temp.isEmpty {
            newURL.append(contentsOf: "?temp=\(temp)")
        }
        guard !isLoading else {return}
        isLoading = true
        networkManager.getModel(results.self, from: newURL){ [weak self] result in
            switch result {
            case .success(let response):
                self?.movieList = response.results
                self?.isLoading = false
                
            case .failure(let error):
                self?.isLoading = false
                print(error)
            }
        }
    }
    func filterMovies(searchText: String) {
        var temp = movieList
        temp.removeAll()
        if searchText.isEmpty {
            loadMoreMovies()
            return
        }
        for movie in movieList{
            if movie.originalTitle.lowercased().contains(searchText.lowercased()){
                temp.append(movie)
            }
            
        }
        movieList = temp
    }
}
