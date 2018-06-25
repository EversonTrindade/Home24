//
//  HomeViewController.swift
//  Home24
//
//  Created by Everson Trindade on 17/06/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import UIKit

fileprivate struct Identifiers {
    let detail = "goToDetail"
}

class HomeViewController: UIViewController, HomeLoadContent {

    private lazy var viewModel: HomeViewModelPresentable = HomeViewModel(self)
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if Reachability.isConnectedToNetwork() {
            getArticles()
//        } else {
//            showDefaultAlert(message: "No Connection", completeBlock: nil)
//        }
    }

    func didLoadContent(_ error: String?) {
        dismissLoader()
        if let error = error {
            showDefaultAlert(message: error, completeBlock: nil)
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    func getArticles() {
        showLoader()
        viewModel.getArticles()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifiers().detail {
            if let detailViewController = segue.destination as? DetailViewController, let articleLink = sender as? String {
                detailViewController.fill(articleLink: articleLink)
            }
        }
    }
}

// MARK: - Table view data source
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if viewModel.getArticlesCount() > 0 {
            let cell: HomeCell = HomeCell.createCell(collectionView: collectionView, indexPath: indexPath)
            cell.fillCell(dto: viewModel.getArticleDTO(index: indexPath.row))
            return cell
        } else {
            let cell: NoConnectionCell = NoConnectionCell.createCell(collectionView: collectionView, indexPath: indexPath)
            cell.isUserInteractionEnabled = false
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let homeCell = cell as? HomeCell {
            homeCell.fillCell(dto: viewModel.getArticleDTO(index: indexPath.row))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Identifiers().detail, sender: viewModel.getArticleLink(index: indexPath.row))
    }
}
