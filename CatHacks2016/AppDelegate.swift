//
//  AppDelegate.swift
//  CatHacks2016
//
//  Created by Chris Martin on 4/9/16.
//  Copyright © 2016 Chris Martin. All rights reserved.
//

import UIKit
import PebbleKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var watch: PBWatch? {
        didSet {
            if let watch = watch {
                watch.appMessagesLaunch({ (_, error) in
                    if error != nil {
                        print("App launched!")
                    }
                })
            }
        }
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let pebble = PBPebbleCentral.defaultCentral()
        pebble.delegate = self
        
        var uuidBytes = Array<UInt8>(count:16, repeatedValue:0)
        let uuid = NSUUID(UUIDString: "86a4631c-05f5-4a63-92ce-fd510995b93f"")
            
        uuid?.getUUIDBytes(&uuidBytes)
        pebble.appUUID = NSData(bytes: &uuidBytes, length: uuidBytes.count)
        
        watch = pebble.lastConnectedWatch()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate: PBPebbleCentralDelegate {
    func pebbleCentral(central: PBPebbleCentral!, watchDidConnect watch: PBWatch!, isNew: Bool) {
        if self.watch != watch {
            self.watch = watch
        }
    }
}

