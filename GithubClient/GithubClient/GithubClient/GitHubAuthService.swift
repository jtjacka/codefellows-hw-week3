//
//  GitHubAuthService.swift
//  GithubClient
//
//  Created by Jeffrey Jacka on 8/18/15.
//  Copyright (c) 2015 Jeffrey Jacka. All rights reserved.
//

import Foundation
import UIKit

class GitHubAuthService {
  
  //GitHub Auth Starts Here
  class func performInitalRequest() {
    UIApplication.sharedApplication().openURL(NSURL(string: "https://github.com/login/oauth/authorize?client_id=\(kGitHubClientID)")!)
  }
  
  //Grab Code from GitHub
  class func exchangeCodeInURL(codeURL : NSURL) {
    if let code = codeURL.query {
      let queryUrl = NSURL(string: "https://github.com/login/oauth/access_token?client_id=\(kGitHubClientID)&client_secret=\(kGitHubClientSecret)&\(code)")!
      let request = NSMutableURLRequest(URL: queryUrl)
      request.HTTPMethod = "POST"
      request.setValue("application/json", forHTTPHeaderField: "Accept")
      
      NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
        if let httpResponse = response as? NSHTTPURLResponse {
          println("Token Response: \(httpResponse.statusCode)")
          
          var error : NSError?
          
          if let rootObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error) as? [String : AnyObject] {
            if let token = rootObject["access_token"] as? String {
              KeychainService.saveToken(token)
              
              NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName(kTokenNotification, object: nil)
              })
            }
          }
        }
      }).resume()
    }
  }
}