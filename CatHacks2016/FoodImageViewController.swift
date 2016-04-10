//
//  FoodImageViewController.swift
//  CatHacks2016
//
//  Created by Chris Martin on 4/9/16.
//  Copyright © 2016 Chris Martin. All rights reserved.
//

import UIKit
import SDWebImage

class FoodImageViewController: UIViewController {

    @IBOutlet weak var foodImageView: UIImageView!
    var imageOverlayView: UIImageView?
    var foodObject: Food! {
        didSet {
            guard self.foodImageView != nil else { return }
            self.foodImageView.sd_setImageWithURL(foodObject.imageURL)
            
            RecipeService.rs.getRecipe(foodObject.id)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard self.foodImageView != nil else { return }
        
        self.foodImageView.sd_setImageWithURL(foodObject.imageURL)
    }
    
    override func viewDidLayoutSubviews() {
        // Create gradient overlay
        guard imageOverlayView == nil else { return }
        let colors = [UIColor.clearColor(), UIColor.blackColor().colorWithAlphaComponent(0.75)]
        let gradient = UIImage(gradientColors: colors)
        self.imageOverlayView = UIImageView(frame: self.foodImageView.bounds)
        self.imageOverlayView!.image = gradient
        self.foodImageView.addSubview(imageOverlayView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
