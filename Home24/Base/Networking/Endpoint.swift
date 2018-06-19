//
//  Endpoint.swift
//  Home24
//
//  Created by Everson Trindade on 18/06/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation

struct Endpoint {
    fileprivate let base = "https://api-mobile.home24.com/api/v2.0/categories/100/articles?appDomain=1&locale=de_DE&limit=10"
    
    var articles: String {
        return base
    }
    
    func addOffSet() -> String {
        //MAIS o offset
        return base
    }
}
