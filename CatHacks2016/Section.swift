//
//  Section.swift
//  CatHacks2016
//
//  Created by Chris Martin on 4/9/16.
//  Copyright © 2016 Chris Martin. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class Section: NSObject {
    var foods: [Food] = [Food]()
    var name: String!
    
    override init() {
        super.init()
    }
    
    convenience init(name: String, json: JSON) {
        self.init()
        
        self.name = name
        
        guard let results = json["results"].array else { return }
        for foodJSON in results {
            foods.append(Food(json: foodJSON))
        }
    }
    
    func addFood(food: Food) {
        self.foods.append(food)
    }
}