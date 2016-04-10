//
//  RecipeService.swift
//  CatHacks2016
//
//  Created by Sam Rose on 4/9/16.
//  Copyright © 2016 Chris Martin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RecipeService {
    static let rs = RecipeService()

    private var _currentRecipe: Recipe?
    
    var currentRecipe: Recipe? {
        return _currentRecipe
    }
    
    func getRecipe(id: String, withCompletionHandler block: ((recipe: Recipe)->())?) {
        let recipeUrl = BASE_URL + id + "/information"
        print("GETTING THE RECIPE")
        Alamofire.request(.GET, recipeUrl, headers: HEADERS).responseJSON {
            response in
            
            if let value = response.result.value {
                let json = JSON(value)
                self._currentRecipe = Recipe(json: json)
                
                block!(recipe: self._currentRecipe!)
            }
        }
    }
    
    func getRecipe(id: String) {
        self.getRecipe(id, withCompletionHandler: nil)
    }
    
    func getRecipeListOfCategory(category: String, withCompletionHandler block: ((json: JSON)->Void )? ) {
        let modifiedString = category.lowercaseString.componentsSeparatedByString(" ").joinWithSeparator("+")
        
        let categoryURL = BASE_URL + "search?type=" + modifiedString
        Alamofire.request(.GET, categoryURL, headers: HEADERS).responseJSON {
            response in
            if let value = response.result.value {
                let json = JSON(value)
                block!(json: json)
            }
        }
    }
    
    func getWatchRecipe(sourceUrl: String, completion: (result: Bool) -> Void) {
        let recipeUrl = API_URL + "recipe?url=" + sourceUrl + "&watch=cathacks"
        
        print(recipeUrl)
        Alamofire.request(.GET, recipeUrl).responseJSON {
            response in
            
            if response.result.error !== nil {
                print(response.result.error);
            }
            
            if let value = response.result.value {
                let json = JSON(value)
                print(json)
                completion(result: true)
            }
        }
    }
    
}