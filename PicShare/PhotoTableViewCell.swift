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
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var likesLabel: UILabel!
    
    var request: Request?
    var photo: Photo!

    func configure(photo: Photo) {
        self.photo = photo
        self.authorLabel.text = photo.authorEmail
        self.timeLabel.text = photo.created?.toAbbrevString()
        self.likesLabel.text = "💙 \(photo.likesCount)"

        reset()

        guard let image = PhotosDataManager.sharedManager.cachedImage(photo) else {
            loadImage()
            return
        }

        populateCell(image)
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

    override func awakeFromNib() {
        super.awakeFromNib()

        let imageViewDoubleTap = UITapGestureRecognizer(target: self, action: "onImageViewDoubleTapped")
        imageViewDoubleTap.numberOfTapsRequired = 2
        self.photoImageView.addGestureRecognizer(imageViewDoubleTap)
    }

    func onImageViewDoubleTapped() {
        photo.likesCount += 1
        photo.save { (success, fault) -> Void in
            if fault != nil {
                
            } else {
                print("successfully saved photo with added like")
                self.configure(self.photo)
            }
        }
    }
}

extension NSDate {
    /**
     A String representation of the date acc. to local timezone in MM-dd-yyyy format (ex: 12/02/90)
     - returns: a String representation of the date in local timezone in MM-dd-yyyy format (ex: 12/02/90)
     */
    func toAbbrevString() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM-dd h:mma"
        return formatter.stringFromDate(self)
    }
}