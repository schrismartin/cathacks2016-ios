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
        }
    }
    
    func pebbleCentral(central: PBPebbleCentral, watchDidDisconnect watch: PBWatch) {
        print("Bye, \(watch.name)!")
        guard _activeWatch == watch else { return }
        
        _activeWatch = nil
    }
}
