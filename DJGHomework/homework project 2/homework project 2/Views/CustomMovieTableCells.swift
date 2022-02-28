//
//  CustomMovieTableCells.swift
//  homework project 2
//
//  Created by Consultant on 2/17/22.
//

import Foundation
import UIKit
import Combine
protocol CustomMovieDelagate: AnyObject{
    func showDetail(row:Int)
}
class CustomMovieTableViewCell: UITableViewCell{
    private let viewModel = ViewModel()
    weak var delegate: CustomMovieTableViewCell?
    var showDetail: (Int) -> Void = { _ in }
    private var rowSelected = 0
    
    @IBAction func btnDetails(_ sender: Any) {
        showDetail(rowSelected)
        delegate?.showDetail(rowSelected)
    }
    @IBOutlet weak var picCheckMark: UIImageView!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var picPoster: UIImageView!
    func configureCell(row: Int, title: String?, overview: String?, favorite: Bool){
        lblOverview.text = overview
        lblTitle.text = title
        rowSelected = row
        if favorite{
            picCheckMark.isHidden = false
        }
    }
    func configureImage(row: Int, viewModel: ViewModel){
        picPoster.image = nil
        viewModel.getPoster(row: row){[weak self] data in
            let image = UIImage(data: data)
            self?.picPoster.image = image
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        picPoster.image = nil
    }
    
}
