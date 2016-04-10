//
//  WatchService.swift
//  CatHacks2016
//
//  Created by Sam Rose on 4/9/16.
//  Copyright © 2016 Chris Martin. All rights reserved.
//

import Foundation
import PebbleKit


class WatchService:NSObject, PBPebbleCentralDelegate {
    
    static let ws = WatchService();
    var dictionary = Dictionary<Int, String>()
    
    private var _pebbleCentral: PBPebbleCentral!
    private var _activeWatch: PBWatch?
    
    var pebbleCentral: PBPebbleCentral {
        return _pebbleCentral
    }
    
    
    func pebbleCentral(central: PBPebbleCentral, watchDidConnect watch: PBWatch, isNew: Bool) {
        print("Hello, \(watch.name)!")
        
        guard _activeWatch == nil else { return }
        _activeWatch = watch
        
        watch.appMessagesLaunch { _ in
            print("launching app")
            self.updateRecipe()
        }
    }
    
    func pebbleCentral(central: PBPebbleCentral, watchDidDisconnect watch: PBWatch) {
        print("Bye, \(watch.name)!")
        guard _activeWatch == watch else { return }
        
        _activeWatch = nil
    }
    
    func updateRecipe() {
        if let sourceUrl = RecipeService.rs.currentRecipe?.sourceUrl where sourceUrl != "" {
            print(sourceUrl)
            RecipeService.rs.getRecipePacket(sourceUrl, completion: {
                ingredient, step  in
                
                self.sendDictionary([NSNumber(int: 0): NSString(string: "test1"), NSNumber(int:1): NSString(string: "test2")], completionHandler: { (error) -> Void in
                    print("Sent message with ingredient", ingredient, "and step", step)
                })
            })
        }
    }
    
    func sendDictionary(dictionary: [NSNumber: NSString], completionHandler: (error: NSError?) -> Void) {
        if dictionary.isEmpty {
            return
        }
        _activeWatch?.appMessagesPushUpdate(dictionary, onSent: {
            watch, msgDictionary, err in
            
            if err != nil {
                print(err)
            } else {
                print(dictionary, "sent to Pebble successfully")
            }
        })
    }
}
