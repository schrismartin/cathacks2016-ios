//
//  TestViewController.swift
//  CatHacks2016
//
//  Created by Sam Rose on 4/9/16.
//  Copyright © 2016 Chris Martin. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var testBtn1: UIButton!
    @IBOutlet weak var testBtn2: UIButton!
    let pebbleController = PebbleController.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func test1(sender: AnyObject) {
        let id = "156992"
        RecipeService.rs.getRecipe(id)
    }
    
    @IBAction func test2(sender: AnyObject) {
        if let sourceUrl = RecipeService.rs.currentRecipe?.sourceUrl where sourceUrl != "" {
            RecipeService.rs.getWatchRecipe(sourceUrl) { (result) in
                print("firebase is doing the work")
            }
        }
    }
}
