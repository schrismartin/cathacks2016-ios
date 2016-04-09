//
//  ViewController.swift
//  CatHacks2016
//
//  Created by Chris Martin on 4/9/16.
//  Copyright © 2016 Chris Martin. All rights reserved.
//

import UIKit
import PebbleKit

class LoadingViewController: UIViewController, PBPebbleCentralDelegate {

    var pebbleCentral: PBPebbleCentral!
    var activeWatch: PBWatch?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pebbleCentral = PBPebbleCentral.defaultCentral()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        pebbleCentral.delegate = self
        pebbleCentral.run()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        pebbleCentral.delegate = nil
    }
    
    func pebbleCentral(central: PBPebbleCentral, watchDidConnect watch: PBWatch, isNew: Bool) {
        print("Hello, \(watch.name)!")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        guard activeWatch == nil else { return }
//        activeWatch = watch
        
//        watch.appMessagesLaunch { [weak self] _ in
        
//        }
        
        print("Loading Segue")
        performSegueWithIdentifier(SEGUE_LOADED, sender: self)
    }
    
    
    func pebbleCentral(central: PBPebbleCentral, watchDidDisconnect watch: PBWatch) {
        print("Bye, \(watch.name)!")
        guard activeWatch == watch else { return }
        
        activeWatch = nil
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}

