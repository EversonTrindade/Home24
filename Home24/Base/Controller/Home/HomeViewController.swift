//
//  HomeViewController.swift
//  Home24
//
//  Created by Everson Trindade on 17/06/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, HomeLoadContent {

    lazy var viewModel: HomeViewModelPresentable = HomeViewModel(homeLoadContent: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getArticles()
    }

    func didLoadContent(_ error: String?) {
        
    }

    func getArticles() {
        viewModel.getArticles()
    }
}
