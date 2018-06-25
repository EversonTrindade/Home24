//
//  CartViewModel.swift
//  Home24
//
//  Created by Everson Trindade on 22/06/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation
import UIKit

protocol CartLoadContent: class {
    func didLoadContent()
}

protocol CartViewModelPresentable: class {
    func getArticlesFromCart()
    func getArticlesCount() -> Int
    func numberOfSections() -> Int
    func numberOfRowsInSection() -> Int
    func heightForRowAt() -> CGFloat
    func getArticleDTO(index: Int) -> ArticleCellDTO
    func removeRowBy(index: Int)
}

class CartViewModel: CartViewModelPresentable {
    
    private weak var cartLoadContent: CartLoadContent?
    var articleCart = [Article]()
    
    init(_ cartLoadContent: CartLoadContent) {
        self.cartLoadContent = cartLoadContent
    }
    
    func getArticlesFromCart() {
        articleCart.removeAll()
        articleCart = FavoriteManager().loadArticles()
        cartLoadContent?.didLoadContent()
    }
    
    func getArticlesCount() -> Int {
        return articleCart.count
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection() -> Int {
        return articleCart.isEmpty ? 1 : articleCart.count
    }
    
    func heightForRowAt() -> CGFloat {
        return articleCart.isEmpty ? 260 : 105
    }
    
    func getArticleDTO(index: Int) -> ArticleCellDTO {
        guard let article = articleCart.object(index: index) else {
            return ArticleCellDTO()
        }
        return ArticleCellDTO(title: article.title ?? "",
                           amount: article.price?.amount ?? "",
                           currency: article.price?.currency ?? "",
                           brand: article.brand?.title ?? "")
    }
    
    func removeRowBy(index: Int) {
        FavoriteManager().remove(favorite: getArticleBy(index: index))
        getArticlesFromCart()
    }
    
    func getArticleBy(index: Int) -> Article {
        if let article = articleCart.object(index: index) {
            return article
        }
        return Article()
    }
}
