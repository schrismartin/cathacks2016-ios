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
    
    func getRecipe(id: String) {
        let recipeUrl = BASE_URL + id + "/information"
        
        Alamofire.request(.GET, recipeUrl, headers: HEADERS).responseJSON {
            response in
            
            if let value = response.result.value {
                let json = JSON(value)
                print(json)
                let newRecipe: Dictionary<String, AnyObject> = [
                    "id": json["id"].int!,
                    "title": json["title"].string!,
                    "sourceUrl": json["sourceUrl"].string!
                ]
                self._currentRecipe = Recipe(recipe: newRecipe)
            }
        }
    }
    
    func getRecipePacket(sourceUrl: String, completion: (ingredient: String, step: String) -> Void) {
        let recipeUrl = API_URL + "recipe?url=" + sourceUrl
        
        print(recipeUrl)
        Alamofire.request(.GET, recipeUrl).responseJSON {
            response in
            
            if response.result.error !== nil {
                print(response.result.error);
            }
            
            if let value = response.result.value {
                let json = JSON(value)
                print(json)
                
                let ingredients = json["ingredients"].arrayValue
                let steps = json["steps"].arrayValue
                
                //send
                completion(ingredient: ingredients[0].stringValue, step: steps[0].stringValue)
            }
        }
    }
}