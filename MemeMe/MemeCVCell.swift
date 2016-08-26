//
//  MemeCVCell.swift
//  MemeMe
//
//  Created by David Moeller on 26/08/16.
//  Copyright © 2016 David Moeller. All rights reserved.
//

import UIKit

class MemeCVCell: UICollectionViewCell {
	
	@IBOutlet weak var imageView: UIImageView!
	
	func initialize(withMeme meme: Meme) {
		self.imageView.image = meme.memeImage
	}
    
}
