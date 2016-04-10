//
//  FeaturedTableViewController.swift
//  
//
//  Created by Chris Martin on 4/9/16.
//
//

import UIKit

class FeaturedTableViewController: UITableViewController, HeaderPageViewControllerDelegate, FoodCollectionViewCellDelegate {

    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var sections: [Section]?
    
    let ORIGINAL_HEIGHT: CGFloat = 190
    let NAVBAR_HEIGHT: CGFloat = 64
    
    var gradientOverlay: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.backgroundColor = UIColor.clearColor()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Set up sections
        if sections == nil {
            self.sections = [Section]()
        }
        
        self.tableView.separatorStyle = .None
        
        for category in CATEGORIES {
            self.getSectionWithName(category) { (section) in
                self.sections?.append(section)
                
                self.tableView.beginUpdates()
                let indexPath = NSIndexPath(forRow: (self.sections!.count - 1) * 2 + 1, inSection: 0)
                let indexPath2 = NSIndexPath(forRow: (self.sections!.count - 1) * 2, inSection: 0)
                self.tableView.insertRowsAtIndexPaths([indexPath, indexPath2], withRowAnimation: .Top)
                self.tableView.endUpdates()
            }
        }
        
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func viewDidLayoutSubviews() {
//        let top = UIColor.blackColor().colorWithAlphaComponent(0.5)
//        let bottom = UIColor.clearColor()
//        let overlay = UIImage(gradientColors: [top, bottom])
//        let ystart = self.headerView.frame.height
//        let backgroundFrame = self.view.frame
//        let frame = CGRectMake(0, ystart, backgroundFrame.width, backgroundFrame.height)
//        if self.gradientOverlay == nil {
//            self.gradientOverlay = UIImageView(frame: frame)
//            self.gradientOverlay.image = overlay
//            self.tableView.backgroundView?.addSubview(self.gradientOverlay)
//        }
//    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard sections != nil else { return 0 }
        return sections!.count * 2
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(CELL_TITLE, forIndexPath: indexPath)
            
            let text = self.sections![indexPath.row/2].name
            cell.textLabel?.text = text.uppercaseString
            cell.accessoryType = .DisclosureIndicator
            cell.selectionStyle = .None
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(CELL_SECTION, forIndexPath: indexPath) as! FeaturedSectionTableViewCell
            
            // Configure the cell...
            cell.accessoryType = .None
            cell.selectionStyle = .None
            
            guard let section = self.sections else { return cell }
            cell.section = section[indexPath.row/2]
            cell.index = indexPath.row/2
            cell.foodDelegate = self
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row % 2 == 0 {
            return 40
        } else {
            return 145
        }
    }
    
    func headerPageViewController(headerPageViewController: HeaderViewController, didUpdatePageIndex count: Int) {
        pageControl.currentPage = count
    }
    
    func headerPageViewController(headerPageViewController: HeaderViewController, didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }


    func getSectionWithName(name: String, completionHandler block: (section: Section)->()) {
        RecipeService.rs.getRecipeListOfCategory(name) { (json) in
            block(section: Section(name: name, json: json))
        }
    }
    
    func foodCollectionViewCell(foodCollectionViewCell: FoodCollectionViewCell, cellTappedAtIndexPath indexPath: NSIndexPath) {
        if let sections = self.sections {
            let foodObjects = sections[indexPath.section].foods
            let foodObject = foodObjects[indexPath.row]
            RecipeService.rs.getRecipe(foodObject.id)
            self.performSegueWithIdentifier(SEGUE_FOOD_VIEWER, sender: foodObject)
        }
    }
    
//    override func scrollViewDidScroll(scrollView: UIScrollView) {
//        let offset = scrollView.contentOffset.y + NAVBAR_HEIGHT
//        
//    }
    
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

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let headerPageViewController = segue.destinationViewController as? HeaderViewController {
            headerPageViewController.pageDelegate = self
        }
        
        if let foodViewerViewController = segue.destinationViewController as? FoodTableViewController {
            foodViewerViewController.foodObject = sender as! Food
        }
    }

}
