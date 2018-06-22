//
//  Article.swift
//  Home24
//
//  Created by Everson Trindade on 18/06/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation

struct Home: Codable {
    var _embedded: Embedded?
}

struct Embedded: Codable {
    var articles: [Article]?
}

struct Article: Codable {
    var title: String?
    var price: Price?
    var description: String?
    var delivery: Delivery?
    var brand: Brand?
    var media: [Media]?
    var availability: Availability?
    var url: String?
    var _links: Link?
}

struct Price: Codable {
    var amount: String?
    var currency: String?
}

struct Delivery: Codable {
    var time: Time?
}

struct Time: Codable {
    var amount: String?
    var units: String?
}

struct Brand: Codable {
    var title: String?
}

struct Media: Codable {
    var uri: String?
}

struct Availability: Codable {
    var text: String?
    var count: Int?
}

struct Link: Codable {
    var selfLink: SelfLink?
    
    enum CodingKeys: String, CodingKey {
        case selfLink = "self"
    }
}

struct SelfLink: Codable {
    var href: String?
}
