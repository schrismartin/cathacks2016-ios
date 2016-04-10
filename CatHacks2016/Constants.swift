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
//let AUTH_VAL = "aSoGZPw5csmshZTJHz4xxmK0hZEcp1EgQuhjsn3svPZIWfS0An"
let AUTH_VAL = "IHAeLyruPLmshnlxecT1FEmQpfNFp1hQa2yjsnEceB3m5nsUDP"
let HEADERS = [
    AUTH_KEY: AUTH_VAL
]

// API Endpoints
let BASE_URL = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/"
let API_URL = "http://recipezwolfram-devskwod.rhcloud.com/"
let IMAGE_PREFIX = "https://spoonacular.com/recipeImages/"

// Categories
let CATEGORY_MAIN_COURSE = "Main Course"
let CATEGORY_SIDE_DISH = "Side Dish"
let CATEGORY_DESSERT = "Dessert"
let CATEGORY_APPETIZER = "Appetizer"
let CATEGORY_SALAD = "Salad"
let CATEGORY_BREAKFAST = "Breakfast"
let CATEGORY_SOUP = "Soup"
let CATEGORY_BEVERAGE = "Beverage"
let CATEGORY_SAUCE = "Sauce"
let CATEGORY_DRINK = "Drink"
let CATEGORIES = [CATEGORY_MAIN_COURSE,
                  CATEGORY_SIDE_DISH,
                  CATEGORY_DESSERT,
                  CATEGORY_APPETIZER,
                  CATEGORY_SALAD,
                  CATEGORY_BREAKFAST,
                  CATEGORY_SOUP,
                  CATEGORY_BEVERAGE,
                  CATEGORY_SAUCE,
                  CATEGORY_DRINK]

// Colors
let COLOR_MAIN = UIColor(red:0.29, green:0.76, blue:0.83, alpha:1.00)
let COLOR_MAIN_POST_TRANSPARENCY = UIColor(red:0.39, green:0.79, blue:0.85, alpha:1.00)

// View Controllers
let VIEW_CONTROLLER_LOADING = "LoadingViewController"
let VIEW_CONTROLLER_FEATURED = "FeaturedTableViewController"
let VIEW_CONTROLLER_FOOD = "FoodTableViewController"
let VIEW_CONTROLLER_FAVORITES = "FavoritesTableViewController.swift"
let VIEW_CONTROLLER_HEADER = "HeaderViewController"

let VIEW_CONTROLLER_FOOD_IMAGE = "FoodImageViewController"

// Tab Controllers
let TAB_CONTROLLER_MAIN = "MainTabViewController"

// TableView Cells
let CELL_SECTION = "SectionTableViewCell"
let CELL_TITLE = "TitleTableViewCell"
let CELL_INGREDIENT = "IngredientCell"

// CollectionView Cells
let CVCELL_FOOD = "FoodCollectionViewCell"

// Segues
let SEGUE_LOADED = "LoadedSegue"
let SEGUE_FOOD_VIEWER = "FoodViewerSegue"
