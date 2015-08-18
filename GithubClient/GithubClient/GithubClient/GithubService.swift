//
//  GithubService.swift
//  GithubClient
//
//  Created by Jeffrey Jacka on 8/17/15.
//  Copyright (c) 2015 Jeffrey Jacka. All rights reserved.
//

import Foundation

enum httpStatusCode {
  
}

class GithubService {
  class func repositoriesForSearchTerm(searchTerm : String, completion: (data : NSData?, error : String?) -> ()){
    let baseURL = "http://localhost:3001/"
    //TODO 2 - Append for final URL
    let finalURL = NSURL(string: baseURL)
    if let finalURL = finalURL {
      NSURLSession.sharedSession().dataTaskWithURL(finalURL, completionHandler: { (data, response, error) -> Void in
        if let error = error {
          //do something with error here
        } else if let httpResponse = response as? NSHTTPURLResponse {
          println(httpResponse.statusCode)
          println(data)
          completion(data: data, error: nil)
        }
      }).resume()
    }

    //TODO 5 - Check for errors
    //TODO 6 - Switch for HTTP Status Code - Maybe use an enum?
  }
}
