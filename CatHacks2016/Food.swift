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
    var imageURL: NSURL!
    var id: String!
    var readyInMinutes: Int!
    
    override init() {
        super.init()
    }
    
//    convenience init(name: String, imageName: String) {
//        self.init()
//        self.name = name
//        self.image = UIImage(named: imageName)
//    }
    
    convenience init(json: JSON) {
        self.init()
        
        if let id = json["id"].int {
            self.id = String(id)
        }
        
        if let name = json["title"].string {
            self.name = name
        }
        
        if let imageURLs = json["imageUrls"].array, let url = imageURLs[0].string {
            var prefixedURL = IMAGE_PREFIX + url
            prefixedURL = prefixedURL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            self.imageURL = NSURL(string: prefixedURL)
        }
        
        if let readyInMinutes = json["readyInMinutes"].int {
            self.readyInMinutes = readyInMinutes
        }
    }
    
//    func getPictureWithName(name: String, withURL url: String) {
//        if let pic = loadImageForUserId(name) {
//            self.image = pic
//            print("Image cached for name: \(name)")
//        } else {
//            print("Image downloaded for name: \(name)")
//            self.image = UIImage() // Placeholder to avoid segfault, update later.
//            var prefixedURL = IMAGE_PREFIX + url
//            prefixedURL = prefixedURL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
//            Alamofire.request(.GET, prefixedURL).response(completionHandler: {
//                (request, response, data, error) in
//                guard let sureData = data else { return }
//                self.image = UIImage(data: sureData, scale: 1)!
//                self.saveImageForUserId(self.name, image: self.image)
//            })
//        }
//    }
    
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
        print(imagePath)
        self.saveImage(image, path: imagePath)
    }
    
    func loadImageForUserId(id: String) -> UIImage? {
        let hash = md5(string: id)
        let imageName = hash + ".png"
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