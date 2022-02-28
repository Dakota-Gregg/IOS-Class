//
//  MovieDetailViewController.swift
//  homework project 2
//
//  Created by Consultant on 2/17/22.
//

import Foundation
import UIKit
import Combine
class MovieDetailViewController: UIViewController, UICollectionViewDelegate{
    
    var viewModel: ViewModel?
    private var subscribers = Set<AnyCancellable>()
    
    @IBOutlet private weak var swFavorite: UISwitch!
    @IBOutlet private weak var picPoster: UIImageView!
    @IBOutlet private weak var navTitleBar: UINavigationItem!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var cltCollection: UICollectionView!
    @IBOutlet private weak var lblDescription: UILabel!
    
    @IBAction func swFavorite(_ sender: Any) {
        if swFavorite.isOn == true{
            viewModel?.favoriteMovie(favMovie: (viewModel?.movieSelected)!)
        }
        else{
            viewModel?.unfavoriteMovie(favMovie: (viewModel?.movieSelected)!)
        }
        
    }
    @IBAction private func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var cltCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBinding()
        cltCollectionView.dataSource = self
        cltCollectionView.delegate = self
        if viewModel?.movieSelected?.isFav == true{
            swFavorite.isOn = true
        }
        else{
            swFavorite.isOn = false
        }
   
    }
    private func setUpBinding() {
        viewModel?.$movieSelected.receive(on: RunLoop.main)
            .sink { [weak self] _ in self?.loadMovie()}
            .store(in: &subscribers)
        
        viewModel?.$productionCompaniesCache.receive(on: RunLoop.main)
            .sink { [weak self] _ in self?.cltCollection.reloadData()}
            .store(in: &subscribers)
        viewModel?.getCompanies()
        viewModel?.$productionCompaniesLogoCache.receive(on:RunLoop.main).sink { [weak self] _ in self?.cltCollection.reloadData()}.store(in: &subscribers)
       // viewModel?.getLogos()
        
    }
    private func loadMovie(){
        let movie = viewModel?.movieSelected
        navTitleBar.title = movie?.originalTitle
        lblTitle.text = movie?.originalTitle
        lblDescription.text = movie?.overview
        viewModel?.getSinglePoster(selectedMovie: movie!){[weak self] data in
            let image = UIImage(data: data)
            self?.picPoster.image = image
        }
    }
}
extension MovieDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.productionCompaniesCache.count ?? 0
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductionCells", for: indexPath) as? ProductionCell
        else{return UICollectionViewCell()}
        let currentCompany = viewModel?.productionCompaniesCache[indexPath.row]
        let name = currentCompany?.name
        cell.configureCell(productionName: name!)
        cell.configureImage(id: currentCompany!.id, path: (currentCompany?.logo_path)!, viewModel: viewModel!)
        return cell
    }
}

