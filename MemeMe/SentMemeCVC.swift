//
//  SentMemeCVC.swift
//  MemeMe
//
//  Created by David Moeller on 26/08/16.
//  Copyright © 2016 David Moeller. All rights reserved.
//

import UIKit

private let reuseIdentifier = "memeCVCell"

class SentMemeCVC: UICollectionViewController {
	
	var memes : [Meme] {
		if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
			return appDelegate.memes
		} else {
			return [Meme]()
		}
	}
	
	@IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
	
	override func viewWillAppear(animated: Bool) {
		collectionView?.contentInset = UIEdgeInsetsMake(65, 0, 50, 0)
		collectionView?.reloadData()
		
		// Configure Collection View Flow Layout
		let space: CGFloat = 3.0
		let dimension = (view.frame.size.width - (2 * space)) / 3.0
		
		flowLayout.minimumInteritemSpacing = space
		flowLayout.minimumLineSpacing = space
		flowLayout.itemSize = CGSizeMake(dimension, dimension)
		
	}

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		
		guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as? MemeCVCell else {
			// Will fail -> Fail fast ;)
			return UICollectionViewCell()
		}
    
		cell.initialize(withMeme: memes[indexPath.row])
    
        return cell
    }
	
	override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		performSegueWithIdentifier("showMeme", sender: indexPath)
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		guard let indexPath = sender as? NSIndexPath else {
			return
		}
		
		guard let vc = segue.destinationViewController as? MemeDetailVC else {
			return
		}
		
		vc.memeImage = memes[indexPath.row].memeImage
		
	}

}
