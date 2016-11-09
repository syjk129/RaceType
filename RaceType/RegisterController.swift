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
    
    @IBOutlet var Nickname: UITextField!
    @IBOutlet var Username: UITextField!
    @IBOutlet var Password: UITextField!
    @IBOutlet var ConfirmPassword: UITextField!
    var thisUser: FIRUser?
    var ref:FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.hideKeyboardWhenTappedAround()
        self.ref = FIRDatabase.database().reference()
    }
    
    @IBAction func CancelDidTapped(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func RegisterDidTapped(_ sender: AnyObject) {
        if !Username.hasText || !Password.hasText || !Nickname.hasText{
            print("Fields cannot be empty")
        }
        else{
            if Password.text! == ConfirmPassword.text!{
                FIRAuth.auth()?.createUser(withEmail: Username.text!, password: Password.text!, completion: {
                    user, error in
                    
                    if error == nil{
                        self.thisUser = FIRAuth.auth()?.currentUser!
                        let nickname = self.Nickname.text!
                        self.ref.child("users").child(self.thisUser!.uid).setValue(["nickname": nickname])
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                        self.present(vc!, animated: false, completion: nil)
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

