//
//  DetailViewController.swift
//  Home24
//
//  Created by Everson Trindade on 17/06/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController, DetailLoadContent {

    // MARK: - IBOutlet
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceTitleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var availabilityTitleLbl: UILabel!
    @IBOutlet weak var availabilityLbl: UILabel!
    @IBOutlet weak var deliveryTitleLbl: UILabel!
    @IBOutlet weak var deliveryLbl: UILabel!
    @IBOutlet weak var descriptionTitleLbl: UILabel!
    @IBOutlet weak var descritionTview: UITextView!
    
    // MARK: - Properties
    private var articleLink = ""
    private lazy var viewModel: DetailViewModelPresentable = DetailViewModel(self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getArticleDetail(articleLink: articleLink)
    }
    
    func fill(articleLink: String) {
        showLoader()
        self.articleLink = articleLink
    }
    
    func didLoadContent(_ articleDetail: Article?, _ error: String?) {
        dismissLoader()
        if let error = error {
            showDefaultAlert(message: error, completeBlock: nil)
        }
        fill(articleDetail)
        
    }
    
    func fill(_ articleDetail: Article?) {
        if let detail = articleDetail {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
                self.priceTitleLbl.text = "Price"
                self.availabilityTitleLbl.text = "Availability"
                self.deliveryTitleLbl.text = "Delivery"
                self.descriptionTitleLbl.text = "Description"
                
                self.nameLbl.text = detail.title
                self.priceLbl.text = "\(detail.price?.amount ?? "") \(detail.price?.currency ?? "")"
                self.availabilityLbl.text = "\(detail.availability?.count?.description ?? "") itens"
                self.deliveryLbl.text = "\(detail.delivery?.time?.amount ?? "") \(detail.delivery?.time?.units ?? "")"
                self.descritionTview.text = detail.description?.htmlToString ?? ""
            }
        }
    }
    
    @IBAction func buyItemAction(_ sender: Any) {
        let action = UIAlertController(title: "Do you want to buy this item?", message: nil, preferredStyle: .actionSheet)
        let noButton = UIAlertAction(title: "No", style: .cancel, handler: nil)
        let yesButton = UIAlertAction(title: "Yes", style: .default) { (action) in
            self.viewModel.saveArticle()
            self.showDefaultAlert(message: "Item added in the cart :)", completeBlock: nil)
        }
        action.addAction(noButton)
        action.addAction(yesButton)
        present(action, animated: true, completion: nil)
    }
}
