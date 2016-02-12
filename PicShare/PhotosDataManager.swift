//
//  File.swift
//  PicShare
//
//  Created by Vik Denic on 2/11/16.
//  Copyright © 2016 nektar labs. All rights reserved.
//

import Foundation
import AlamofireImage

class PhotosDataManager {

    static let sharedManager = PhotosDataManager()

    let imageCache = AutoPurgingImageCache(
        memoryCapacity: 100 * 1024 * 1024,
        preferredMemoryUsageAfterPurge: 60 * 1024 * 1024
    )

    func cacheImage(photo: Photo, image: Image) {
        imageCache.addImage(image, withIdentifier: photo.objectId!)
    }

    func cachedImage(photo: Photo) -> Image? {
        return imageCache.imageWithIdentifier(photo.objectId!)
    }
}