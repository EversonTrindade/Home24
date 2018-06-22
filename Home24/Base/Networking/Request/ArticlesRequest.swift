//
//  ArticleRequest.swift
//  Home24
//
//  Created by Everson Trindade on 18/06/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation

class ArticlesRequest: Requestable {
    
    func request(completion: @escaping ([Article]?, String?) -> Void) {
        guard let url = URL(string: Endpoint().articles) else {
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
            guard let articles = try? JSONDecoder().decode(Home.self, from: dataFromService) else {
                completion(nil, "Serialization Error")
                return
            }
            completion(articles._embedded?.articles, nil)
        }.resume()
    }
//        guard let mock = testReadJSON(name: "ArticlesMocked"),
//            let articles = try? JSONDecoder().decode(Home.self, from: mock) else {
//            completion(nil, "Not found")
//            return
//        }
//
//        completion(articles._embedded?.articles, nil)
//    }
//
//    func testReadJSON(name: String) -> Data? {
//        let path = Bundle.main.path(forResource: name, ofType: "json")
//        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
//        return data
//    }
}
