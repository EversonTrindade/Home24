//
//  HomeViewModel.swift
//  Home24
//
//  Created by Everson Trindade on 17/06/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation

protocol HomeLoadContent: class {
    func didLoadContent(_ error: String?)
}

protocol HomeViewModelPresentable: class {
    func getArticles()
}

class HomeViewModel: HomeViewModelPresentable {
    
    private weak var homeLoadContent: HomeLoadContent?
    private var articles = [Article]()
    
    init() { }
    
    init(homeLoadContent: HomeLoadContent?) {
        self.homeLoadContent = homeLoadContent
    }
    
    func getArticles() {
        ArticleRequest().request { (result, error) in
            guard let articles = result else {
                self.homeLoadContent?.didLoadContent("Error")
                return
            }
            self.articles = articles
            self.homeLoadContent?.didLoadContent(nil)
        }
    }
}
