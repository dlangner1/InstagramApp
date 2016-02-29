//
//  LoginViewController.swift
//  Instagram2
//
//  Created by Dustin Langner on 2/26/16.
//  Copyright © 2016 Dustin Langner. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleImage = UIImage(named: "InstagramTitle")
        self.navigationItem.titleView = UIImageView(image: titleImage)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onSignInPressed(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("You are logged in")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            } else {
                print("failed to log in")
                if (error?.code == 200) {
                    let alert = UIAlertController(title: "Username Missing", message: "Please input username", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                
                } else if (error?.code == 201) {
                    let alert = UIAlertController(title: "Password Missing", message: "Please input password", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                }
            }
        
        }
    
    }
    
    
    @IBAction func onSignUpPressed(sender: AnyObject) {
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                print("Created a user")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            } else { // handles possible failures
                print(error?.localizedDescription)
                if (error?.code == 202) {
                    print("Username is already taken")
                    let alert = UIAlertController(title: "Username Taken", message: "Try a different name!", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                } else if (error?.code == 200) {
                    let alert = UIAlertController(title: "Username Missing", message: "Please input username", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                
                } else if (error?.code == 201) {
                    let alert = UIAlertController(title: "Password Missing", message: "Please input password", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func logoutToLoginScreen(segue:UIStoryboardSegue) {
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
