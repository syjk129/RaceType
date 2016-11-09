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
    
    override func viewDidAppear(_ animated: Bool) {
        if FIRAuth.auth()?.currentUser != nil {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
            self.present(vc!, animated: false, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func Register(_ sender: AnyObject) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Register")
        self.present(vc!, animated: false, completion: nil)
    }
    
    @IBAction func Login(_ sender: AnyObject) {
        if !Username.hasText{
            print("Username cannot be empty")
        }
        else if !Password.hasText{
            print("Password cannot be empty")
        }
        else{
            FIRAuth.auth()?.signIn(withEmail: Username.text!, password: Password.text!, completion: {
                user, error in
                if error == nil{
//                    thisUser = user
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    self.present(vc!, animated: false, completion: nil)
                }
                else{
                    print("Username and Password combination does not exist")
                }
            })
        }
    }
}
