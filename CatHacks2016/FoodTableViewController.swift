//
//  FoodTableViewController.swift
//  CatHacks2016
//
//  Created by Chris Martin on 4/9/16.
//  Copyright © 2016 Chris Martin. All rights reserved.
//

import UIKit

class FoodTableViewController: UITableViewController {
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var pebbleButton: UIButton!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var barHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var barYPosConstraint: NSLayoutConstraint!
    
    let VIEW_HEIGHT: CGFloat = 358
    let BAR_ORIGINAL_HEIGHT: CGFloat = 54
    let HEADER_HEIGHT: CGFloat = 358 - 54
    let BAR_NEW_HEIGHT: CGFloat = 64
    let BAR_Y_POS: CGFloat = 0
    
    var foodObject: Food! {
        didSet {
            print(foodObject.name)
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
        
        self.pebbleButton.tintColor = UIColor.whiteColor()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 50
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CELL_INGREDIENT, forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        if offset < 0 {
            self.headerHeightConstraint.constant = HEADER_HEIGHT - offset
        } else {
            self.headerHeightConstraint.constant = HEADER_HEIGHT
        }
        
        if offset < HEADER_HEIGHT && offset > 0 {
            let percent = offset/HEADER_HEIGHT
            let newHeight = BAR_ORIGINAL_HEIGHT + (BAR_NEW_HEIGHT - BAR_ORIGINAL_HEIGHT) * percent
            barHeightConstraint.constant = newHeight
        } else if offset >= HEADER_HEIGHT {
            barHeightConstraint.constant = BAR_NEW_HEIGHT
        } else {
            barHeightConstraint.constant = BAR_ORIGINAL_HEIGHT
        }
        
        let differential = BAR_NEW_HEIGHT - BAR_ORIGINAL_HEIGHT
        if offset >= HEADER_HEIGHT - differential {
            self.barYPosConstraint.constant = HEADER_HEIGHT - differential - offset
        } else {
            self.barYPosConstraint.constant = BAR_Y_POS
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
