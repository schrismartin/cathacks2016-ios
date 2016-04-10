//
//  FeaturedSectionTableViewCell.swift
//  CatHacks2016
//
//  Created by Chris Martin on 4/9/16.
//  Copyright © 2016 Chris Martin. All rights reserved.
//

import UIKit

class FeaturedSectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var index: Int!
    
    var section: Section? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var foodDelegate: FoodCollectionViewCellDelegate?
    var layout = UICollectionViewFlowLayout()
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.collectionViewLayout = layout
        
        self.layout.itemSize = CGSize(width: 114, height: 132)
        self.layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! FoodCollectionViewCell
        let newIndexPath = NSIndexPath(forRow: indexPath.row, inSection: self.index)
        foodDelegate?.foodCollectionViewCell(cell, cellTappedAtIndexPath: newIndexPath)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.section != nil ? (self.section?.foods?.count)! : 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CVCELL_FOOD, forIndexPath: indexPath) as! FoodCollectionViewCell
        cell.foodObject = section?.foods![indexPath.row]
        
        return cell
    }
}

protocol FoodCollectionViewCellDelegate {
    
    /**
     Called when the cell is tapped.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter count: the total number of pages.
     */
    func foodCollectionViewCell(foodCollectionViewCell: FoodCollectionViewCell, cellTappedAtIndexPath indexPath: NSIndexPath)
    
}