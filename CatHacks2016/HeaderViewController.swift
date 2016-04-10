//
//  HeaderViewController.swift
//  CatHacks2016
//
//  Created by Chris Martin on 4/9/16.
//  Copyright © 2016 Chris Martin. All rights reserved.
//

import UIKit

class HeaderViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var orderedViewControllers = [FoodImageViewController]()
    
    var foodArray: [Food] = [Food]()
    
    var pageDelegate: HeaderPageViewControllerDelegate?
    
    var currentViewController: FoodImageViewController?
    
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataSource = self
        self.delegate = self
        
        RecipeService.rs.getRecipeListOfCategory(CATEGORY_MAIN_COURSE) { (json) in
            let headerSection = Section(name: CATEGORY_MAIN_COURSE, json: json)
            self.foodArray = headerSection.foods
            
            self.orderedViewControllers = []
            for food in self.foodArray {
                self.orderedViewControllers.append(self.newFoodControllerWithFood(food))
            }
            
            if let firstViewController = self.orderedViewControllers.first {
                self.setViewControllers([firstViewController], direction: .Forward, animated: true, completion: nil)
                self.currentViewController = firstViewController
            }
            
            self.pageDelegate?.headerPageViewController(self, didUpdatePageCount: self.orderedViewControllers.count)
        }
        
        self.setUpTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? FoodImageViewController else { return nil }
        guard let viewControllerIndex = orderedViewControllers.indexOf(vc) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        self.setUpTimer()
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? FoodImageViewController else { return nil }
        guard let viewControllerIndex = orderedViewControllers.indexOf(vc) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        self.setUpTimer()
        return orderedViewControllers[nextIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first as? FoodImageViewController,
            let index = orderedViewControllers.indexOf(firstViewController) {
            pageDelegate?.headerPageViewController(self, didUpdatePageIndex: index)
        }
    }
    
    func advanceByOne() {
        if let currentViewController = self.currentViewController, let viewController = pageViewController(self, viewControllerAfterViewController: currentViewController) as? FoodImageViewController {
            setViewControllers([viewController], direction: .Forward, animated: true, completion: nil)
            self.currentViewController = viewController
            
            if let index = orderedViewControllers.indexOf(self.currentViewController!) {
                pageDelegate?.headerPageViewController(self, didUpdatePageIndex: index)
            }
        }
    }
    
    func setUpTimer() {
        guard self.timer != nil else {
            self.timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(HeaderViewController.advanceByOne), userInfo: nil, repeats: false)
            return
        }
        
        self.timer.invalidate()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(HeaderViewController.advanceByOne), userInfo: nil, repeats: false)
    }
    
    
    private func newFoodControllerWithFood(foodObject: Food) -> FoodImageViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(VIEW_CONTROLLER_FOOD_IMAGE) as! FoodImageViewController
        vc.foodObject = foodObject

        return vc
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

protocol HeaderPageViewControllerDelegate {
    
    /**
     Called when the number of pages is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter count: the total number of pages.
     */
    func headerPageViewController(headerPageViewController: HeaderViewController, didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func headerPageViewController(headerPageViewController: HeaderViewController, didUpdatePageIndex index: Int)
    
}
