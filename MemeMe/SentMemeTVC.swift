//
//  SentMemeTVC.swift
//  MemeMe
//
//  Created by David Moeller on 26/08/16.
//  Copyright © 2016 David Moeller. All rights reserved.
//

import UIKit

class SentMemeTVC: UITableViewController {
	
	var memes : [Meme] {
		if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
			return appDelegate.memes
		} else {
			return [Meme]()
		}
	}

	@IBAction func doRefresh(sender: AnyObject) {
		tableView.reloadData()
		sender.endRefreshing()
	}
	
	override func viewWillAppear(animated: Bool) {
		tableView.contentInset = UIEdgeInsetsMake(65, 0, 50, 0)
		tableView.reloadData()
	}
	
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCellWithIdentifier("memeTVCell", forIndexPath: indexPath) as? MemeTVCell else {
			// Will fail -> Fail fast ;)
			return UITableViewCell()
		}
		
		cell.initialize(withMeme: memes[indexPath.row])

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
			guard let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else {
				return
			}
			appDelegate.memes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

}
