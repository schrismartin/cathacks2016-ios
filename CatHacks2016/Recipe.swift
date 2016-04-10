//
//  Recipe.swift
//  CatHacks2016
//
//  Created by Sam Rose on 4/9/16.
//  Copyright © 2016 Chris Martin. All rights reserved.
//

import Foundation


class Recipe {
    private var _id: Int!
    private var _title: String!
    private var _sourceUrl: String!
    
    var id: Int {
        return _id
    }
    
    var title: String {
        return _title
    }
    
    var sourceUrl: String {
        return _sourceUrl
    }
    
    init(recipe: Dictionary<String, AnyObject>) {
        _id = recipe["id"] as! Int
        _title = recipe["title"] as! String
        _sourceUrl = recipe["sourceUrl"] as! String
    }
}