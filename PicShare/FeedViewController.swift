//
//  ViewController.swift
//  PicShare
//
//  Created by Vik Denic on 2/9/16.
//  Copyright © 2016 nektar labs. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    var backendless = Backendless.sharedInstance()

    var photos = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        checkForCurrentUser()
    }

    func checkForCurrentUser() {
        if backendless.userService.currentUser == nil {
            print("No current user")
            performSegueWithIdentifier("feedToLoginSegue", sender: self)
        } else {
            print("Current user is: \(Backendless().userService.currentUser)")
        }
    }
}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("feedCell")! as UITableViewCell
//        let photo = self.photos[indexPath.row]
//        cell.textLabel?.text = blurb.message
//        cell.detailTextLabel?.text = blurb.authorEmail
        return cell
    }
}

