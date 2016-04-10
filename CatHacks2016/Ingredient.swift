//
//  Ingredient.swift
//  CatHacks2016
//
//  Created by Chris Martin on 4/10/16.
//  Copyright © 2016 Chris Martin. All rights reserved.
//

import Foundation
import SwiftyJSON

class Ingredient {
    
    var _amount: Int!
    var _unit: String!
    var _name: String!
    var _description: String!
    
    var amount: Int {
        return _amount
    }
    var unit: String {
        return _unit
    }
    var name: String {
        return _name
    }
    var description: String {
        return _description
    }
    
    init() { }
    
    convenience init(json: JSON) {
        self.init()
        
        if let amount = json["amount"].int {
            self._amount = amount
        }
        if let unit = json["unit"].string {
            self._unit = unit
        }
        if let name = json["name"].string {
            self._name = name
        }
        if let description = json["originalString"].string {
            self._description = description
        }
    }
}