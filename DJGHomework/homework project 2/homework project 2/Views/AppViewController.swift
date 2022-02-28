//
//  AppViewController.swift
//  homework project 2
//
//  Created by Consultant on 2/15/22.
//

import Foundation
import UIKit
import Combine
import CoreData
private var models = [movie]()
class AppViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate{
    private let viewModel = ViewModel()
    private var subscribers = Set<AnyCancellable>()
    private var subscribersPosters = Set<AnyCancellable>()
    @IBOutlet private weak var txtName: UITextField!
    @IBOutlet private weak var lblName: UILabel!
    @IBOutlet private weak var tblMoviesList: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBAction private func segFavorites(_ sender: Any) {
        
    }
    @IBAction private func txtName(_ sender: Any) {
        lblName.text = txtName.text
        UserDefaults.standard.set(txtName.text, forKey: "Name")
        lblName.isHidden = false
        txtName.isHidden = true
        if txtName.text == "" {
            dismiss(animated: true, completion: nil)
        }
    }
    @IBAction private func btnNameChange(_ sender: Any) {
        txtName.isHidden = false
        lblName.isHidden = true
        txtName.becomeFirstResponder()
    }
    override func viewDidLoad() {
        lblName.text = UserDefaults.standard.string(forKey: "Name")
        txtName.text = lblName.text
        setUpBinding()
        tblMoviesList.delegate = self
        tblMoviesList.dataSource = self
        searchBar.delegate = self
        super.viewDidLoad()
        tblMoviesList.rowHeight = UITableView.automaticDimension
        tblMoviesList.estimatedRowHeight = 100
    }
    private func setUpBinding() {
        viewModel
            .$movieList
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in self?.tblMoviesList.reloadData()}
            .store(in: &subscribers)
        viewModel.getMovies()
        viewModel
            .$imageCache.receive(on: RunLoop.current)
            .sink{[weak self] _ in self?.tblMoviesList.reloadData()}
            .store(in: &subscribersPosters)
        viewModel.$favList.receive(on: RunLoop.main)
            .sink{[weak self] _ in self?.tblMoviesList.reloadData()}
            .store(in: &subscribers)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destination = segue.destination as? MovieDetailViewController
            destination?.viewModel = viewModel
        }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterMovies(searchText: searchText)
    }
    
}


extension AppViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? CustomMovieTableViewCell
        else{return UITableViewCell()}
        let currentMovie = viewModel.movieList[indexPath.row]
        cell.configureCell(row: indexPath.row, title: currentMovie.originalTitle, overview: currentMovie.overview, favorite: currentMovie.isFav)
        cell.configureImage(row: indexPath.row, viewModel: viewModel)
        cell.showDetail = { [weak self] row in
                    self?.viewModel.selectMovie(row: indexPath.row)
                    self?.performSegue(withIdentifier: "MoviesToDetails", sender: nil)
                }
    
        return cell
    }
}


