
//  ArticleModelTests.swift
//  Home24Tests
//
//  Created by Everson Trindade on 22/06/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import XCTest
@testable import Home24

extension XCTestCase {
    func readJSON(name: String) -> Data? {
        let path = Bundle.main.path(forResource: name, ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        return data
    }
}

class ArticleModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testShouldValidateArrayOfArticle() {
        guard let mock = readJSON(name: "ArticlesMocked"),
            let articles = try? JSONDecoder().decode(Home.self, from: mock) else {
                return
        }
        if let article = articles._embedded?.articles?.object(index: 0) {
            XCTAssert(article.title == "Premium Komfortmatratze Smood")
            XCTAssert(article.price?.amount == "699.99")
            XCTAssert(article.price?.currency == "EUR")
            XCTAssert(article.description == nil)
            XCTAssert(article.delivery?.time?.amount == "3")
            XCTAssert(article.delivery?.time?.units == "days")
            XCTAssert(article.brand?.title == "Smood")
            XCTAssert(article.media?.object(index: 0)?.uri == "https://cdn1.home24.net/resized/media/catalog/product/m/a/matratzenbezug-smood-webstoff-180-x-200cm-3477221.png?output-format=jpg&interpolation=progressive-bicubic")
            XCTAssert(article.url == nil)
            XCTAssert(article._links?.selfLink?.href == "https://api-mobile.home24.com/api/v1/articles/000000001000091266?appDomain=1&locale=de_DE")
        }
        
    }
    
    func testShouldValidateArticleDetail() {
        guard let mock = readJSON(name: "DetailsMocked"),
            let detail = try? JSONDecoder().decode(Article.self, from: mock) else {
                return
        }
        
        XCTAssert(detail.title == "Premium Komfortmatratze Smood - 180 x 200cm")
        XCTAssert(detail.price?.amount == "699.99")
        XCTAssert(detail.price?.currency == "EUR")
        XCTAssert(detail.description == "<h2>Erholsam schlafen in geprüfter Qualität</h2><br>Die bequeme Premium Komfortmatratze Smood ist mit einer innovativen <b>Faserschaum-Gel-Technologie</b> versehen, die sich durch eine hohe Elastizität und Langlebigkeit auszeichnet. Der abnehmbare Bezug hat eine softe Oberfläche und ist mit einem bequemen Reißverschluss ausgestattet. Die <b>optimierte Feuchtigkeits- und Temperaturregulation</b> der Premium Komfortmatratze Smood sorgt für ein angenehmes Liegegefühl, wozu auch die <b>sieben Liegezonen mit unterschiedlicher Stützkraft</b> beitragen. <b>Schadstoffgeprüfte Materialien</b> und die hochwertige Verarbeitung sind weitere Kennzeichen der Kaltschaummatratze, die sich auch für die Nutzung mit einem verstellbaren Lattenrahmen eignet.")
        XCTAssert(detail.delivery?.time?.amount == "3")
        XCTAssert(detail.delivery?.time?.units == "days")
        XCTAssert(detail.brand == nil)
        XCTAssert(detail.media?.object(index: 0)?.uri == "https://cdn1.home24.net/resized/media/catalog/product/m/a/matratzenbezug-smood-webstoff-180-x-200cm-3477221.png?output-format=jpg&interpolation=progressive-bicubic")
        XCTAssert(detail.availability?.text == "Lieferbar")
        XCTAssert(detail.availability?.count == 6)
        XCTAssert(detail.url == "https://www.home24.de/produkt/premium-komfortmatratze-smood-180-x-200cm")
        XCTAssert(detail._links?.selfLink?.href == "https://api-mobile.home24.com/api/v1/articles/000000001000091266?locale=de_DE")
    }
}
