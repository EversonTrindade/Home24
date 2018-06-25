//
//  CartCell.swift
//  Home24
//
//  Created by Everson Trindade on 22/06/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import UIKit

class CartCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var brandLbl: UILabel!
    
    func fillCell(dto: ArticleCellDTO) {
        titleLbl.text = dto.title
        priceLbl.text = "\(dto.amount) \(dto.currency) "
        brandLbl.text = dto.brand
    }
}
