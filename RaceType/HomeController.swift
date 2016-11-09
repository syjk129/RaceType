//
//  HomeController.swift
//  RaceType
//
//  Created by Shawn Kim on 6/3/16.
//  Copyright © 2016 Trisk. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UIViewController {

    @IBOutlet var NickName: UILabel!
    @IBOutlet var WPM: UILabel!
    @IBOutlet var Entry: UITextField!
    @IBOutlet var TextLabel: UILabel!
    let textString = "Hello my name is Shawn Kim."
    var textArray: [String] = []
    var textIndex = 0
    var intIndex = 0
    var counter = 0
    var timer = Timer()
    var ref:FIRDatabaseReference!
    var user:FIRUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Make keyboard appear immediately
        Entry.becomeFirstResponder()
        
        //Observe if there are changes in the text field
        Entry.addTarget(self, action: #selector(HomeController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        
        //Get text from database and set the label to it
        TextLabel.text = textString
        
        //Initialize the text array to the given text string
        textArray = textString.characters.split{$0 == " "}.map(String.init)
        
        print(textString.characters.count)
        self.user = FIRAuth.auth()?.currentUser!
        self.ref = FIRDatabase.database().reference()
//        self.ref.child("users").child(user.uid).setValue(["username": "test"])
        
        //Start the timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidChange(_ textField: UITextField){
        if textIndex < textArray.count{
            if Entry.hasText{
                if Entry.text!.range(of: " ") != nil{
                    //Check if input text is equal to label text
                    if Entry.text! == textArray[textIndex] + " "{
                        //Reset entry text field
                        Entry.text = ""
                        
                        //Get Index of text in the sentence
                        let length = textArray[textIndex].characters.count
                        intIndex = intIndex + length + 1
                        
                        //Update color of text label
                        var mutableString = NSMutableAttributedString()
                        mutableString = NSMutableAttributedString(string: textString)
                        mutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.green, range: NSRange(location:0, length: intIndex-1))
                        TextLabel.attributedText = mutableString
                        
                        //Update the index
                        textIndex += 1
                        
                        if textIndex == textArray.count{
                            TextLabel.text = "Completed!"
                            WPM.text = "Your WPM was \(60 / counter * textArray.count)"
                            timer.invalidate()
                        }
                        
                    }
                }
            }
        }
    }
    
    @IBAction func Logout(_ sender: AnyObject) {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login")
            self.present(vc!, animated: false, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    // called every time interval from the timer
    func timerAction() {
        counter += 1
        WPM.text = "\(counter)"
    }
}
