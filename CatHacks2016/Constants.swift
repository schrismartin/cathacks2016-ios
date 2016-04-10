//
//  Constants.swift
//  CatHacks2016
//
//  Created by Chris Martin on 4/9/16.
//  Copyright © 2016 Chris Martin. All rights reserved.
//

import Foundation
import UIKit

// API Header Info
let AUTH_KEY = "X-Mashape-Key"
let AUTH_VAL = "aSoGZPw5csmshZTJHz4xxmK0hZEcp1EgQuhjsn3svPZIWfS0An"
let HEADERS = [
    AUTH_KEY: AUTH_VAL
]

// API Endpoints
let BASE_URL = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/"
let API_URL = "http://recipezwolfram-devskwod.rhcloud.com/"

// Colors
let COLOR_MAIN = UIColor(red:0.29, green:0.76, blue:0.83, alpha:1.00)
let COLOR_MAIN_POST_TRANSPARENCY = UIColor(red:0.39, green:0.79, blue:0.85, alpha:1.00)

// View Controllers
let VIEW_CONTROLLER_LOADING = "LoadingViewController"
let VIEW_CONTROLLER_FEATURED = "FeaturedTableViewController"
let VIEW_CONTROLLER_FOOD = "FoodTableViewController"
let VIEW_CONTROLLER_FAVORITES = "FavoritesTableViewController.swift"
let VIEW_CONTROLLER_HEADER = "HeaderViewController"

let VIEW_CONTROLLER_RED = "RedViewController"
let VIEW_CONTROLLER_BLUE = "BlueViewController"

// Tab Controllers
let TAB_CONTROLLER_MAIN = "MainTabViewController"

// TableView Cells
let CELL_SECTION = "SectionTableViewCell"

// Segues
let SEGUE_LOADED = "LoadedSegue"
