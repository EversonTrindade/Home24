//
//  HomeViewModelTests.swift
//  Home24Tests
//
//  Created by Everson Trindade on 22/06/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import XCTest
@testable import Home24

class HomeViewModelTests: XCTestCase {
    
    let viewModel = HomeViewModel()
    
    override func setUp() {
        super.setUp()

        guard let mock = readJSON(name: "ArticlesMocked"),
            let articles = try? JSONDecoder().decode(Home.self, from: mock) else {
                return
        }

        viewModel.articles = (articles._embedded?.articles)!
    }
    
    func testShouldValidateNumberOfSections() {
        XCTAssert(viewModel.numberOfSections() == 1)
    }
    
    func testShouldValidateNumberOfItemsInSection() {
        XCTAssert(viewModel.numberOfItemsInSection() == 10)
    }
    
    func testShouldValidateGetArticleDTO() {
        XCTAssert(viewModel.getArticleDTO(index: 0).title == "Premium Komfortmatratze Smood")
        XCTAssert(viewModel.getArticleDTO(index: 0).amount == "699.99")
        XCTAssert(viewModel.getArticleDTO(index: 0).currency == "EUR")
        XCTAssert(viewModel.getArticleDTO(index: 0).brand == "Smood")
    }
    
    func testShouldValidateGetArticleLink() {
        XCTAssert(viewModel.getArticleLink(index: 0) == "https://api-mobile.home24.com/api/v1/articles/000000001000091266?appDomain=1&locale=de_DE")
    }
    
}
