//
//  ViewController.swift
//  GithubClient
//
//  Created by Jeffrey Jacka on 8/17/15.
//  Copyright (c) 2015 Jeffrey Jacka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    GitHubAuthService.performInitalRequest()
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

