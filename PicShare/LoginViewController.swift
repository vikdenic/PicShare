//
//  LoginViewController.swift
//  PicShare
//
//  Created by Vik Denic on 2/9/16.
//  Copyright © 2016 nektar labs. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var backendless = Backendless.sharedInstance()

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onSignUpButtonTapped(sender: AnyObject) {
        registerUser()
    }

    @IBAction func onLoginButtonTapped(sender: AnyObject) {
        loginUser()
    }

    func registerUser() {
        let user = BackendlessUser()
        user.email = usernameTextField.text
        user.password = passwordTextField.text

        backendless.userService.registering(user,
            response: { (registeredUser) -> Void in
                print("User has been registered: \(registeredUser)")

                //Still need to log the user in
                self.loginUser()
            }) { (fault) -> Void in
                print("Server reported an error: \(fault)")
        }
    }

    func loginUser() {
        backendless.userService.login(usernameTextField.text, password: passwordTextField.text, response: { (loggedInUser) -> Void in
            print("User has been logged in: \(loggedInUser)")
            self.dismissViewControllerAnimated(true, completion: nil)
            }) { (fault) -> Void in
                print("Server reported an error: \(fault)")
        }
    }
}
