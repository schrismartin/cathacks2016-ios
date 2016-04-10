//
//  FoodCollectionViewCell.swift
//  CatHacks2016
//
//  Created by Chris Martin on 4/9/16.
//  Copyright © 2016 Chris Martin. All rights reserved.
//

import UIKit

class FoodCollectionViewCell: UICollectionViewCell {
    
    var indexPath: NSIndexPath!
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            let top = UIColor.clearColor()
            let bottom = UIColor.blackColor().colorWithAlphaComponent(0.5)
            let overlay = UIImage(gradientColors: [top, bottom])
            if self.overlayImage == nil {
                self.overlayImage = UIImageView(frame: self.imageView.frame)
                self.overlayImage.image = overlay
                self.addSubview(overlayImage)
            } else {
                self.overlayImage = UIImageView(frame: self.imageView.frame)
                self.overlayImage.image = overlay
            }
        }
    }
    
    @IBOutlet weak var label: UILabel!
    var overlayImage: UIImageView!
    
    var foodObject: Food! {
        didSet {
            guard let view = self.imageView else { return }
//            view.image = foodObject.image
//            view.sd_setImageWithURL(foodObject.imageURL)
            view.sd_setImageWithURL(foodObject.imageURL)
            guard let label = self.label else { return }
            label.text = foodObject.name
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func setUpView() {
        
    }
}
