//
//  ViewController.swift
//  PicShare
//
//  Created by Vik Denic on 2/9/16.
//  Copyright © 2016 nektar labs. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class FeedViewController: UIViewController {

    var backendless = Backendless.sharedInstance()

    var photos = [Photo]()

    @IBOutlet var tableView: UITableView!

    let imageCache = NSCache()

    override func viewDidLoad() {
        super.viewDidLoad()
        checkForCurrentUser()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        retrievePhotos()
    }

    func checkForCurrentUser() {
        if backendless.userService.currentUser == nil {
            print("No current user")
            performSegueWithIdentifier("feedToLoginSegue", sender: self)
        } else {
            print("Current user is: \(Backendless().userService.currentUser)")
        }
    }

    func retrievePhotos() {
        let query = BackendlessDataQuery()
        // Use backendless.persistenceService to obtain a ref to a data store for the class

        let dataStore = self.backendless.persistenceService.of(Photo.ofClass()) as IDataStore
        dataStore.find(query, response: { (retrievedCollection) -> Void in
            print("Successfully retrieved: \(retrievedCollection)")
            self.photos = retrievedCollection.data as! [Photo]
            self.tableView.reloadData()
            }) { (fault) -> Void in
                print("Server reported an error: \(fault)")
        }
    }
}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("photoCell")! as! PhotoTableViewCell

        cell.configure(photos[indexPath.row])

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(photos[(tableView.indexPathForSelectedRow?.row)!])
    }
}

