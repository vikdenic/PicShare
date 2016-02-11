//
//  CaptureViewController.swift
//  PicShare
//
//  Created by Vik Denic on 2/11/16.
//  Copyright © 2016 nektar labs. All rights reserved.
//

import UIKit

class CaptureViewController: UIViewController {

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
        self.tabBarController?.selectedIndex = 0
        dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.tabBarController?.selectedIndex = 0
        dismissViewControllerAnimated(true, completion: nil)
    }
}
