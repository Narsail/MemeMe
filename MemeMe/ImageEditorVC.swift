//
//  ImageEditorVC.swift
//  MemeMe
//
//  Created by David Moeller on 25/08/16.
//  Copyright © 2016 David Moeller. All rights reserved.
//

import UIKit

class ImageEditorVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var cameraButtonView: UIBarButtonItem!
	
	@IBOutlet weak var bottomBar: UIToolbar!
	
	@IBOutlet weak var topTextField: UITextField!
	@IBOutlet weak var bottomTextField: UITextField!
	
	@IBOutlet weak var shareButton: UIBarButtonItem!
	
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		// Check if Camera Image Picker is available
		cameraButtonView.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
		
		// Prepare Text Attribute Dictionary for TextFields
		let memeTextAttributes = [
			NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
			NSStrokeWidthAttributeName: -5.0,
			NSStrokeColorAttributeName: UIColor.blackColor(),
			NSForegroundColorAttributeName: UIColor.whiteColor(),
		]
		
		// Change Attributes of Textfields
		topTextField.defaultTextAttributes = memeTextAttributes
		topTextField.textAlignment = NSTextAlignment.Center
		bottomTextField.defaultTextAttributes = memeTextAttributes
		bottomTextField.textAlignment = NSTextAlignment.Center
		
		// Subscribe to Notifications
		subscribeToKeyboardNotifications()
		
		// Check if can be shared
		shareButton.enabled = imageView.image != nil
		
	}
	
	override func viewWillDisappear(animated: Bool) {
		unsubscribeToKeyboardNotifications()
		super.viewWillDisappear(animated)
	}
	
	func generateMemedImage() -> UIImage {
		
		// TODO: Hide toolbar and navbar
		
		bottomBar.hidden = true
		
		// Render view to an image
		UIGraphicsBeginImageContext(self.view.frame.size)
		view.drawViewHierarchyInRect(self.view.frame,
		                             afterScreenUpdates: true)
		let memedImage : UIImage =
			UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		// TODO:  Show toolbar and navbar
		bottomBar.hidden = false
		
		return memedImage
	}
	
	func save() {
		
		let meme = Meme(topText: topTextField.text, bottomTextString: bottomTextField.text, originalImage: imageView.image, memeImage: generateMemedImage())
		
	}
	
	// MARK: - Keyboard Stuff
	
	func subscribeToKeyboardNotifications() {
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ImageEditorVC.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ImageEditorVC.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
	}
	
	func unsubscribeToKeyboardNotifications() {
		NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
		NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
	}
	
	func keyboardWillShow(notification: NSNotification){
		// With the reprsented implementation i got weird transitions when clicking on the top textfield and directly clicking on the bottom field
		// afterwards. It double shifted to the top.
		if bottomTextField.editing {
			view.frame.origin.y -= getKeyboardHeight(notification)
		}
	}
	
	func keyboardWillHide(notification: NSNotification) {
		if view.frame.origin.y != 0 {
			view.frame.origin.y += getKeyboardHeight(notification)
		}
	}
	
	func getKeyboardHeight(notification: NSNotification) -> CGFloat {
		
		guard let userInfo = notification.userInfo as? [String: AnyObject] else {
			return 0
		}
		guard let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
			return 0
		}
		
		return keyboardSize.CGRectValue().height
	}
	
	// MARK: - Actions

	@IBAction func pickAnImage(sender: AnyObject) {
		
		let imagePickerVC = UIImagePickerController()
		imagePickerVC.delegate = self
		imagePickerVC.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
		
		self.presentViewController(imagePickerVC, animated: true, completion: nil)
		
	}
	
	@IBAction func pickAnImageFromCamera(sender: AnyObject) {
		let imagePickerVC = UIImagePickerController()
		imagePickerVC.delegate = self
		imagePickerVC.sourceType = UIImagePickerControllerSourceType.Camera
		
		self.presentViewController(imagePickerVC, animated: true, completion: nil)
	}
	
	@IBAction func share(sender: AnyObject) {
		let activityViewController = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
		self.presentViewController(activityViewController, animated: true, completion: {
			// Save the Meme
			self.save()
		})
	}
	
	// MARK: - Delegates
	// MARK: Image Picker Delegate
	
	func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
		if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
			self.imageView.image = image
			self.shareButton.enabled = true
		}
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
}
