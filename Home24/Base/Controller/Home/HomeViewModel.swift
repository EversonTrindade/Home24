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
    func numberOfSections() -> Int
    func numberOfItemsInSection() -> Int
    func getArticleDTO(index: Int) -> HomeCellDTO
    func getArticleLink(index: Int) -> String
}

class HomeViewModel: HomeViewModelPresentable {
    
    private weak var homeLoadContent: HomeLoadContent?
    private var articles = [Article]()
    
    init() { }
    
    init(homeLoadContent: HomeLoadContent?) {
        self.homeLoadContent = homeLoadContent
    }
    
    func getArticles() {
        ArticlesRequest().request { (result, error) in
            guard let articles = result else {
                self.homeLoadContent?.didLoadContent(error)
                return
            }
            self.articles = articles
            self.homeLoadContent?.didLoadContent(nil)
        }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItemsInSection() -> Int {
        return articles.count
    }
    
    func getArticleDTO(index: Int) -> HomeCellDTO {
        guard let article = self.articles.object(index: index) else {
            return HomeCellDTO()
        }
        return HomeCellDTO(title: article.title ?? "",
                           amount: article.price?.amount ?? "",
                           currency: article.price?.currency ?? "",
                           brand: article.brand?.title ?? "")
    }
    
    func getArticleLink(index: Int) -> String {
        guard let article = self.articles.object(index: index) else {
            return ""
        }
        return article._links?.selfLink?.href ?? ""
    }
    
}
