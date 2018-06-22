//
//  HomeCell.swift
//  Home24
//
//  Created by Everson Trindade on 19/06/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import UIKit

struct HomeCellDTO {
//    var image = ""
    var title = ""
    var amount = ""
    var currency = ""
    var brand = ""
}

class HomeCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var brandLbl: UILabel!
    
    
    func fillCell(dto: HomeCellDTO) {
        titleLbl.text = dto.title
        priceLbl.text = "\(dto.currency) \(dto.amount)"
        brandLbl.text = dto.brand
    }
}
