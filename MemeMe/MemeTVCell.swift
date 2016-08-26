//
//  MemeTVCell.swift
//  MemeMe
//
//  Created by David Moeller on 26/08/16.
//  Copyright © 2016 David Moeller. All rights reserved.
//

import UIKit

class MemeTVCell: UITableViewCell {

	@IBOutlet weak var memeImageView: UIImageView!
	@IBOutlet weak var topLabel: UILabel!
	@IBOutlet weak var bottomLabel: UILabel!
	
	func initialize(withMeme meme: Meme) {
		self.memeImageView.image = meme.memeImage
		
		if meme.topText != nil {
			topLabel.text = meme.topText!
		}
		
		if meme.bottomText != nil {
			bottomLabel.text = meme.bottomText!
		}
	}

}
