//
//  Recipe.swift
//  CatHacks2016
//
//  Created by Sam Rose on 4/9/16.
//  Copyright © 2016 Chris Martin. All rights reserved.
//

import Foundation
import SwiftyJSON

class Recipe {
    private var _id: String!
    private var _title: String!
    private var _sourceUrl: String!
    private var _ingredients: [Ingredient]!
    
    var id: String {
        return _id
    }
    
    var title: String {
        return _title
    }
    
    var sourceUrl: String {
        return _sourceUrl
    }
    
    var ingredients: [Ingredient] {
        return _ingredients
    }
    
    init() { /* I mean, something will eventually happen here maybe */ }
    
    convenience init(recipe: Dictionary<String, AnyObject>) {
        self.init()
        _id = recipe["id"] as! String
        _title = recipe["title"] as! String
        _sourceUrl = recipe["sourceUrl"] as! String
    }
    
    convenience init(json: JSON) {
        self.init()
        
        if let id = json["id"].string {
            _id = id
        }
        if let title = json["title"].string {
            _title = title
        }
        if let sourceUrl = json["sourceUrl"].string {
            _sourceUrl = sourceUrl
        }
        
        self._ingredients = [Ingredient]()
        if let ingredients = json["extendedIngredients"].array {
            for ingredientJSON in ingredients {
                self._ingredients.append(Ingredient(json: ingredientJSON))
            }
        }
    }
}