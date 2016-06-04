//
//  LoginController.swift
//  RaceType
//
//  Created by Shawn Kim on 6/3/16.
//  Copyright © 2016 Trisk. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {

    @IBOutlet var Username: UITextField!
    @IBOutlet var Password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func Register(sender: AnyObject) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Register")
        self.presentViewController(vc!, animated: false, completion: nil)
    }
    
    @IBAction func Login(sender: AnyObject) {
        if !Username.hasText(){
            print("Username cannot be empty")
        }
        else if !Password.hasText(){
            print("Password cannot be empty")
        }
        else{
            FIRAuth.auth()?.signInWithEmail(Username.text!, password: Password.text!, completion: {
                user, error in
                if error == nil{
                    let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Home")
                    self.presentViewController(vc!, animated: false, completion: nil)
                }
                else{
                    print("Username and Password combination does not exist")
                }
            })
        }
    }
}