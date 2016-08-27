//
//  MemeDetailVC.swift
//  MemeMe
//
//  Created by David Moeller on 27/08/16.
//  Copyright © 2016 David Moeller. All rights reserved.
//

import UIKit

class MemeDetailVC: UIViewController {
	
	@IBOutlet weak var memeImageView: UIImageView!
	
	var memeImage: UIImage?
	
	override func viewWillAppear(animated: Bool) {
		memeImageView.image = memeImage
	}

}
