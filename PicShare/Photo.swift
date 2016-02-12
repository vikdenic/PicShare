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
    var likesCount = 0 as Int
    var ownerId: String?
    var created: NSDate?

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

    func save(completed : (success : Bool, fault : Fault!) -> Void) {
        let backendless = Backendless.sharedInstance()

        backendless.persistenceService.of(Photo.ofClass()).save(self, response: { (savedPhoto) -> Void in
            print("successfully saved photo: \(savedPhoto)")
            completed(success: true, fault: nil)
//            self.tabBarController?.selectedIndex = 0
//            self.dismissViewControllerAnimated(true, completion: nil)
            }) { (fault) -> Void in
                print("Server reported an error: \(fault)")
                completed(success: false, fault: fault)
//                self.tabBarController?.selectedIndex = 0
//                self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
