//
//  FavoriteManager.swift
//  Home24
//
//  Created by Everson Trindade on 24/06/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation
import CoreData

class FavoriteManager {
    
    func save(favorite: Article) {
        let dataBase = LocalDataBase()
        let managedContext = dataBase.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteArticle", in: managedContext)!
        let article = NSManagedObject(entity: entity, insertInto: managedContext)
        
        article.setValue(favorite.title, forKey: "title")
        article.setValue(favorite.description, forKey: "product_description")
        article.setValue(favorite.price?.amount, forKey: "price_amount")
        article.setValue(favorite.price?.currency, forKey: "price_currency")
        article.setValue(favorite.delivery?.time?.amount, forKey: "delivery_amount")
        article.setValue(favorite.delivery?.time?.units, forKey: "delivery_units")
        article.setValue(favorite.availability?.count, forKey: "availability_number")
        
        do {
            try managedContext.save()
        } catch  {
            print("ErrorSaving")
        }
    }
    
    func remove(favorite: Article) {
        let dataBase = LocalDataBase()
        let managedContext = dataBase.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteArticle")
        if let results = try? managedContext.fetch(request) as? [FavoriteArticle] {
            let article = results?.filter { $0.title == favorite.title }.first
            if let articleModel = article {
                managedContext.delete(articleModel)
                try? managedContext.save()
            }
        }
    }
    
    func loadArticles() -> [Article] {
        let dataBase = LocalDataBase()
        let managedContext = dataBase.persistentContainer.viewContext
        var favorites = [Article]()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteArticle")
        if let results = try? managedContext.fetch(request) as? [FavoriteArticle] {
            results?.forEach { favorites.append(setFavoriteArticle(with: $0))}
        }
        return favorites
    }
    
    func setFavoriteArticle(with object: FavoriteArticle) -> Article {
        var favorite = Article()
        favorite.title = object.title
        favorite.description = object.product_description
        favorite.price?.amount = object.price_amount
        favorite.price?.currency = object.price_amount
        favorite.delivery?.time?.amount = object.delivery_amount
        favorite.delivery?.time?.units = object.delivery_units
        favorite.availability?.count = Int(object.availability_number)
        return favorite
    }
}
