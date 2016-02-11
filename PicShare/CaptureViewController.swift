//
//  CaptureViewController.swift
//  PicShare
//
//  Created by Vik Denic on 2/11/16.
//  Copyright © 2016 nektar labs. All rights reserved.
//

import UIKit

class CaptureViewController: UIViewController {

    var backendless = Backendless.sharedInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        presentPicker()
    }

    func presentPicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true

        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            imagePicker.sourceType = .Camera
        }

        presentViewController(imagePicker, animated: true, completion: nil)
    }
}

extension CaptureViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {

        let fileName = "img/\(NSUUID().UUIDString).jpeg"
        backendless.fileService.upload(fileName, content: UIImageJPEGRepresentation(image, 0.5), response: { (uploadedFile) -> Void in
                print("successfully uploaded: \(uploadedFile)")
                self.tabBarController?.selectedIndex = 0
                self.dismissViewControllerAnimated(true, completion: nil)
            }) { (fault) -> Void in
                print("Server reported an error: \(fault)")
                self.tabBarController?.selectedIndex = 0
                self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.tabBarController?.selectedIndex = 0
        dismissViewControllerAnimated(true, completion: nil)
    }
}
