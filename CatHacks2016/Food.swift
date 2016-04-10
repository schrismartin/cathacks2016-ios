//
//  FeaturedFood.swift
//  CatHacks2016
//
//  Created by Chris Martin on 4/9/16.
//  Copyright © 2016 Chris Martin. All rights reserved.
//

import Foundation
import UIKit

class Food: NSObject {
    var name: String!
    var image: UIImage!
    
    init(name: String, imageName: String) {
        super.init()
        self.name = name
        self.image = UIImage(named: imageName)
    }
}