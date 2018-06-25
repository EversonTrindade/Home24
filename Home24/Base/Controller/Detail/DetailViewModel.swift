//
//  DetailViewModel.swift
//  Home24
//
//  Created by Everson Trindade on 17/06/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation

protocol DetailLoadContent: class {
    func didLoadContent(_ articleDetail: Article?, _ error: String?)
}

protocol DetailViewModelPresentable: class {
    func getArticleDetail(articleLink: String)
    func saveArticle()
}

class DetailViewModel: DetailViewModelPresentable {
    
    private var articleDetail: Article?
    private weak var detailLoadContent: DetailLoadContent?
    
    init() { }
    
    init(_ detailLoadContent: DetailLoadContent?) {
        self.detailLoadContent = detailLoadContent
    }
    
    func getArticleDetail(articleLink: String) {
        DetailRequest.init(articleLink: articleLink).request { (result, error) in
            guard let detail = result else {
                self.detailLoadContent?.didLoadContent(nil, error)
                return
            }
            self.detailLoadContent?.didLoadContent(detail, nil)
            self.articleDetail = detail
        }
    }
    
    func saveArticle() {
        if let article = self.articleDetail {
            FavoriteManager().save(favorite: article)
        }
    }
}

