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
    func getArticleDTO(index: Int) -> ArticleCellDTO
    func getArticleLink(index: Int) -> String
    func getArticlesCount() -> Int
}

class HomeViewModel: HomeViewModelPresentable {
    
    private weak var homeLoadContent: HomeLoadContent?
    var articles = [Article]()
    
    init() { }
    
    init(_ homeLoadContent: HomeLoadContent?) {
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
        return articles.count > 0 ? articles.count : 1
    }
    
    func getArticleDTO(index: Int) -> ArticleCellDTO {
        guard let article = self.articles.object(index: index) else {
            return ArticleCellDTO()
        }
        return ArticleCellDTO(title: article.title ?? "",
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
    
    func getArticlesCount() -> Int {
        return articles.count
    }

}
