//
//  LoginViewController.swift
//  
//
//  Created by Jeffrey Jacka on 8/18/15.
//
//

import UIKit

class LoginViewController: UIViewController {

  @IBOutlet weak var loginButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      NSNotificationCenter.defaultCenter().addObserver(self, selector: "newToken", name: kTokenNotification, object: nil)
      
      
      self.view.bringSubviewToFront(self.loginButton)
      println("login screen loaded")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func loginClicked(sender: AnyObject) {
    
    GitHubAuthService.performInitalRequest()
    
  }
  
  func newToken() {
    performSegueWithIdentifier("ShowMainScreen", sender: nil)
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self, name: kTokenNotification, object: nil)
  }

}
