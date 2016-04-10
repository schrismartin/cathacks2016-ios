//
//  FeaturedFood.swift
//  CatHacks2016
//
//  Created by Chris Martin on 4/9/16.
//  Copyright © 2016 Chris Martin. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import CommonCrypto

class Food: NSObject {
    var name: String!
    var image: UIImage!
    var preparationTime: String?
    var cookingTime: String?
    
    override init() {
        super.init()
    }
    
    convenience init(name: String, imageName: String) {
        self.init()
        self.name = name
        self.image = UIImage(named: imageName)
    }
    
    convenience init(json: JSON) {
        self.init()
        
        print(json)
    }
    
    func getPictureWithName(name: String, withURL url: String) {
        if let pic = loadImageForUserId(name) {
            self.image = pic
        } else {
            Alamofire.request(.GET, url).response(completionHandler: { (request, response, data, error) in
                self.image = UIImage(data: data!, scale: 1)!
                self.saveImageForUserId(self.name, image: self.image)
            })
        }
    }
    
    func md5(string string: String) -> String {
        var digest = [UInt8](count: Int(CC_MD5_DIGEST_LENGTH), repeatedValue: 0)
        if let data = string.dataUsingEncoding(NSUTF8StringEncoding) {
            CC_MD5(data.bytes, CC_LONG(data.length), &digest)
        }
        
        var digestHex = ""
        for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        
        return digestHex
    }
    
    func saveImageForUserId(id: String, image: UIImage) {
        let hash = md5(string: id)
        let imageName = hash + ".png"
        let imagePath = fileInDocumentsDirectory(imageName)
        self.saveImage(image, path: imagePath)
    }
    
    func loadImageForUserId(id: String) -> UIImage? {
        let hash = md5(string: id)
        let imageName = id + ".png"
        let imagePath = fileInDocumentsDirectory(imageName)
        return loadImageFromPath(imagePath)
    }
    
    func saveImage(image: UIImage, path: String) -> Bool {
        let pngImageData = UIImagePNGRepresentation(image)
        let result = pngImageData!.writeToFile(path, atomically: true)
        return result
    }
    
    func getDocumentsURL() -> NSURL {
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        return documentsURL
    }
    
    func fileInDocumentsDirectory(filename: String) -> String {
        let fileURL = getDocumentsURL().URLByAppendingPathComponent(filename)
        return fileURL.path!
    }
    
    func loadImageFromPath(path: String) -> UIImage? {
        let image = UIImage(contentsOfFile: path)
        return image
        
    }
}