//
//  CartViewController.swift
//  Home24
//
//  Created by Everson Trindade on 22/06/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, CartLoadContent {
    
    private lazy var viewModel: CartViewModelPresentable = CartViewModel(self)
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.getArticlesFromCart()

    }

    func didLoadContent() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}   

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.numberOfRowsInSection())
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.getArticlesCount() > 0 {
            let cell: CartCell = CartCell.createCell(tableView: tableView, indexPath: indexPath)
            cell.fillCell(dto: viewModel.getArticleDTO(index: indexPath.row))
            return cell
        } else {
            let cell: EmptyCartCell = EmptyCartCell.createCell(tableView: tableView, indexPath: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if viewModel.getArticlesCount() > 0 {
            
            let delete = UITableViewRowAction(style: .destructive, title: "delete") { (action, indexPath) in
                self.viewModel.removeRowBy(index: indexPath.row)
            }
            return [delete]
        }
        return []
    }
}
