//
//  Photo.swift
//  PicShare
//
//  Created by Vik Denic on 2/9/16.
//  Copyright © 2016 nektar labs. All rights reserved.
//

import UIKit

class Photo: NSObject {
    var objectId: String?
    var fileName: String?
    var authorEmail: String?
    var ownerId: String?

    // Initialize from arbitrary data
    init(authorEmail: String, fileName: String) {
        self.authorEmail = authorEmail
        self.fileName = fileName
        super.init()
    }

    override init() {
        super.init()
    }

    class func retrieveAllPhotos(completed : (photos : [Photo]?, fault : Fault?) -> Void) {
        let backendless = Backendless.sharedInstance()
        let query = BackendlessDataQuery()
        // Use backendless.persistenceService to obtain a ref to a data store for the class

        let dataStore = backendless.persistenceService.of(Photo.ofClass()) as IDataStore
        dataStore.find(query, response: { (retrievedCollection) -> Void in
            print("Successfully retrieved: \(retrievedCollection)")
            completed(photos: retrievedCollection.data as? [Photo], fault: nil)
        }) { (fault) -> Void in
            print("Server reported an error: \(fault)")
            completed(photos: nil, fault: fault)
        }
    }
}
