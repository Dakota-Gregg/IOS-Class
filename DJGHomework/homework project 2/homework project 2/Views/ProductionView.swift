//
//  ProductionView.swift
//  homework project 2
//
//  Created by Consultant on 2/22/22.
//

import Foundation
import UIKit
class ProductionCell: UICollectionViewCell {
    @IBOutlet weak var picProductionPoster: UIImageView!
    
    @IBOutlet weak var lblProductionName: UILabel!
    
    func configureCell(productionName: String) {
        lblProductionName.text = productionName
    }
    func configureImage(id: Int, path: String, viewModel: ViewModel){
        picProductionPoster.image = nil
        viewModel.getCompanyLogo(id: id, logoPath: path){[weak self] data in
            let image = UIImage(data: data)
            self?.picProductionPoster.image = image
        }
    }
}
