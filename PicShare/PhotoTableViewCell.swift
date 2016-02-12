//
//  PhotoTableViewCell.swift
//  PicShare
//
//  Created by Vik Denic on 2/9/16.
//  Copyright © 2016 nektar labs. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet var photoImageView: UIImageView!
    
    var request: Request?
    var photo: Photo!

    func configure(photo: Photo) {
        self.photo = photo
        reset()
        if let image = PhotosDataManager.sharedManager.cachedImage(photo) {
            populateCell(image)
            return
        }
        loadImage()
    }


    func reset() {
        photoImageView.image = nil
        request?.cancel()
    }

    func loadImage() {
        Alamofire.request(.GET, photo.fileName!).responseImage { (response) -> Void in
            guard let image = response.result.value else { return }
            self.populateCell(image)
            PhotosDataManager.sharedManager.cacheImage(self.photo, image: image)
        }
    }

    func populateCell(image: UIImage) {
        photoImageView.image = image
    }

}
