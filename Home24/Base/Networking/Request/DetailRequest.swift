//
//  DetailRequest.swift
//  Home24
//
//  Created by Everson Trindade on 21/06/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation

class DetailRequest: Requestable {
    
    private var articleLink = ""
    
    init(articleLink: String) {
        self.articleLink = articleLink
    }
    
    func request(completion: @escaping (Article?, String?) -> Void) {
        guard let url = URL(string: self.articleLink) else {
            completion(nil, "Wrong URL")
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            if let error = error {
                completion(nil, error.localizedDescription)
                return
            }
            guard let dataFromService = data else {
                completion(nil, "No data found")
                return
            }
            guard let article = try? JSONDecoder().decode(Article.self, from: dataFromService) else {
                completion(nil, "Serialization Error")
                return
            }
            completion(article, nil)
            }.resume()
    }
}
