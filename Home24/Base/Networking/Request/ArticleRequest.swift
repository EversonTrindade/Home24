//
//  ArticleRequest.swift
//  Home24
//
//  Created by Everson Trindade on 18/06/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation

class ArticleRequest: Requestable {
    
    func request(completion: @escaping ([Article]?, CustomError?) -> Void) {
        guard let url = URL(string: Endpoint().articles) else {
            completion(nil, CustomError())
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            if let error = error {
                completion(nil, CustomError(error: error.localizedDescription as? Error))
                return
            }
            guard let dataFromService = data else {
                completion(nil, CustomError())
                return
            }
            guard let articles = try? JSONDecoder().decode(Home.self, from: dataFromService) else {
                completion(nil, CustomError())
                return
            }
            completion(articles._embedded?.articles, nil)
        }.resume()
    }
}
