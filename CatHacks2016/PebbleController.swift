//
//  PebbleController.swift
//  CatHacks2016
//
//  Created by Sam Rose on 4/10/16.
//  Copyright © 2016 Chris Martin. All rights reserved.
//


import PebbleKit

protocol PebbleControllerDelegate {
    func pebbleController(pebbleController: PebbleController, receivedMessage: Dictionary<NSObject, AnyObject>)
}

class PebbleController: NSObject, PBPebbleCentralDelegate {
    
    class var instance : PebbleController {
        struct Static {
            static let instance : PebbleController = PebbleController()
        }
        return Static.instance
    }
    
    var watch: PBWatch?
    var delegate: PebbleControllerDelegate?
    
    //Set the app UUID
    var UUID: String? {
        didSet {
            let myAppUUID = NSUUID(UUIDString: self.UUID!)
            var myAppUUIDbytes: UInt8 = 0
            myAppUUID?.getUUIDBytes(&myAppUUIDbytes)
            PBPebbleCentral.defaultCentral().appUUID = myAppUUID
            if (self.watch != nil) {
                self.watch?.appMessagesAddReceiveUpdateHandler({ (watch, msgDictionary) -> Bool in
                    print("Message received")
                    self.delegate?.pebbleController(self, receivedMessage: msgDictionary)
                    return true
                })
            }
        }
        
    }
    
    override init() {
        super.init()
        PBPebbleCentral.defaultCentral().delegate = self
        self.watch = PBPebbleCentral.defaultCentral().lastConnectedWatch()
        if (self.watch != nil) {
            print("Pebble found: \(self.watch!.name)")
        }
        PBPebbleCentral.defaultCentral().run()
    }
    
    func pebbleCentral(central: PBPebbleCentral, watchDidConnect watch: PBWatch, isNew: Bool) {
        print("Pebble did connect: \(watch.name)")
        self.launchApp { (error) in
            if error !== nil {
                print(error)
            }
        }
        NSNotificationCenter.defaultCenter().postNotificationName("pebbleConnected", object: nil)
    }
    
    func pebbleCentral(central: PBPebbleCentral, watchDidDisconnect watch: PBWatch) {
        print("Pebble did disconnect: \(watch.name)")
        if (self.watch == watch) {
            self.watch = nil
        }
        self.launchApp { (error) in
            if error != nil {
                print(error)
            }
        }
        NSNotificationCenter.defaultCenter().postNotificationName("pebbleDisconnected", object: nil)
    }
    
    func launchApp(completionHandler: (error: NSError?) -> Void) {
        self.watch?.appMessagesLaunch({ (watch, error) -> Void in
            completionHandler(error: error)
        })
    }
    
    func killApp(completionHandler: (error: NSError?) -> Void) {
        self.watch?.appMessagesKill({ (watch, error) -> Void in
            completionHandler(error: error)
        })
    }
}