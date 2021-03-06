//
//  FoodTableViewController.swift
//  CatHacks2016
//
//  Created by Chris Martin on 4/9/16.
//  Copyright © 2016 Chris Martin. All rights reserved.
//

import UIKit

class FoodTableViewController: UITableViewController {
    
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var pebbleButton: UIButton!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var barHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var barYPosConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleYPosConstraint: NSLayoutConstraint!
    
    let VIEW_HEIGHT: CGFloat = 358
    let BAR_ORIGINAL_HEIGHT: CGFloat = 54
    let HEADER_HEIGHT: CGFloat = 358 - 54
    let BAR_NEW_HEIGHT: CGFloat = 64
    let BAR_Y_POS: CGFloat = 0
    let TITLE_MAIN_POS: CGFloat = 12
    let TITLE_RAISED_POS: CGFloat = 22
    
    @IBOutlet weak var headerImageView: UIImageView! {
        didSet {
            guard let food = foodObject else { return }
            headerImageView.sd_setImageWithURL(food.imageURL)
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            guard let food = foodObject else { return }
            titleLabel.text = food.name
        }
    }
    
    @IBOutlet weak var preparationTimeLabel: UILabel! {
        didSet {
            if let food = self.foodObject {
                preparationTimeLabel.text = "Preparation Time: \(food.readyInMinutes) Mins"
            }
        }
    }
    
    var foodObject: Food! {
        didSet {
            if let title = titleLabel, let header = headerImageView {
                title.text = foodObject.name
    //            header.image = foodObject.image
                header.sd_setImageWithURL(foodObject.imageURL)
            }
            
            if let prep = self.preparationTimeLabel {
                prep.text = "Preparation Time: \(foodObject.readyInMinutes) Mins"
            }
            
            RecipeService.rs.getRecipe(foodObject.id) { (recipe) in
                self.recipeObject = recipe
            }
        }
    }
    
    var recipeObject: Recipe! {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Hide navbar and set insets accordingly.
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.barView.clipsToBounds = true
        
        self.pebbleButton.tintColor = UIColor.whiteColor()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50
        
        self.pebbleButton.addTarget(self, action: #selector(FoodTableViewController.pebbleButtonPressed(_:)), forControlEvents: .TouchUpInside)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "INGREDIENTS"
        } else {
            return nil
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let recipe = self.recipeObject else { return 0 }
        return recipe.ingredients.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let differential = BAR_NEW_HEIGHT - BAR_ORIGINAL_HEIGHT
        let animated = self.tableView.contentOffset.y < HEADER_HEIGHT - differential
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CELL_INGREDIENT, forIndexPath: indexPath)

        guard let recipe = self.recipeObject else { return cell }
        // Configure the cell...
        cell.textLabel?.text = recipe.ingredients[indexPath.row].description

        return cell
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        // Handle Header Height
        if offset < 0 {
            self.headerHeightConstraint.constant = HEADER_HEIGHT - offset
        } else {
            self.headerHeightConstraint.constant = HEADER_HEIGHT
        }
        
        // Handle Bar Height
        if offset < HEADER_HEIGHT && offset > 0 {
            let percent = offset/HEADER_HEIGHT
            let newHeight = BAR_ORIGINAL_HEIGHT + (BAR_NEW_HEIGHT - BAR_ORIGINAL_HEIGHT) * percent
            barHeightConstraint.constant = newHeight
            
            // Handle Label Position and Subtitle Alpha
            let newPos = TITLE_RAISED_POS - (TITLE_RAISED_POS - TITLE_MAIN_POS) * percent
            titleYPosConstraint.constant = newPos
            self.preparationTimeLabel.alpha = 1 - percent
            
        } else if offset >= HEADER_HEIGHT {
            barHeightConstraint.constant = BAR_NEW_HEIGHT
        } else {
            barHeightConstraint.constant = BAR_ORIGINAL_HEIGHT
        }
        
        // Handle Bar Position
        let differential = BAR_NEW_HEIGHT - BAR_ORIGINAL_HEIGHT
        if offset >= HEADER_HEIGHT - differential {
            self.barYPosConstraint.constant = HEADER_HEIGHT - differential - offset
        } else {
            self.barYPosConstraint.constant = BAR_Y_POS
        }
    }
    
    @IBAction func pebbleButtonPressed(sender: UIButton) {
        print("did tap pebble button")
        RecipeService.rs.getWatchRecipe() { (result) in
            print("firebase is doing the work")
            let alert = UIAlertController(title: "Recipe Sent", message: "Your recipe has been sent to your Pebble smartwatch", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
