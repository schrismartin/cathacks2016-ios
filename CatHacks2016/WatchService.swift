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
    
    private var _pebbleCentral: PBPebbleCentral!
    private var _activeWatch: PBWatch?
    
    var pebbleCentral: PBPebbleCentral {
        return _pebbleCentral
    }
    
    var activeWatch: PBWatch? {
        return _activeWatch
    }

    
    override init() {
        _pebbleCentral = PBPebbleCentral.defaultCentral()
    }
    
//    init(pebbleCentral: PBPebbleCentral, activeWatch: PBWatch?) {
//        _pebbleCentral = pebbleCentral
//        
//        if let watch = activeWatch as? PBWatch {
//            _activeWatch = watch
//        }
//    }
    
    func connectWatch() {
        _pebbleCentral.delegate = self
        _pebbleCentral.run()
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
