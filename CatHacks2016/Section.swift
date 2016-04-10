//
//  Section.swift
//  CatHacks2016
//
//  Created by Chris Martin on 4/9/16.
//  Copyright © 2016 Chris Martin. All rights reserved.
//

import Foundation
import UIKit

class Section: NSObject {
    var foods: [Food]?
    var name: String!
    
    init(name: String) {
        self.name = name
        self.foods = [Food]()
    }
    
    func addFood(food: Food) {
        self.foods?.append(food)
    }
}