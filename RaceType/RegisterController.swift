//
//  RegisterController.swift
//  RaceType
//
//  Created by Shawn Kim on 6/3/16.
//  Copyright © 2016 Trisk. All rights reserved.
//

import UIKit
import Firebase

class RegisterController: UIViewController {
    
    @IBOutlet var Username: UITextField!
    @IBOutlet var Password: UITextField!
    @IBOutlet var ConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func Register(sender: AnyObject) {
        if !Username.hasText() || !Password.hasText(){
            print("Username or password cannot be empty")
        }
        else{
            if Password.text! == ConfirmPassword.text!{
                FIRAuth.auth()?.createUserWithEmail(Username.text!, password: Password.text!, completion: {
                    user, error in
                    
                    if error != nil{
                        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Home")
                        self.presentViewController(vc!, animated: false, completion: nil)
                    }
                    else{
                        print(error)
                    }
                })
            }
            else{
                print("Passwords do not match!")
            }
        }
    }
}

