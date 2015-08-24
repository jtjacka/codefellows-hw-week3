//
//  GithubService.swift
//  GithubClient
//
//  Created by Jeffrey Jacka on 8/17/15.
//  Copyright (c) 2015 Jeffrey Jacka. All rights reserved.
//

import Foundation
import UIKit

enum httpStatusCode {
  
}

class GithubService {
  
  //Create Singleton
  static let sharedService = GithubService()
  
  let baseURL = "https://api.github.com/"
  let token  = KeychainService.loadToken()


  
  private init() {}
  
  //Search Repoitories
  class func repositoriesForSearchTerm(searchTerm : String, completion: (data : NSData?, error : String?) -> ()){
    //Set Up Session
    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    if let token = self.sharedService.token {
      let additionalHeaders = ["Authorization" : "token \(token)"]
      config.HTTPAdditionalHeaders = additionalHeaders
    }
    let session = NSURLSession(configuration: config)
    //Has to be done everytime because Apple says so
    
    //Concatenate URL
    let queryUrl = self.sharedService.baseURL + "search/repositories?q=\(searchTerm)"
    let finalURL = NSURL(string: queryUrl)
    
    //Query GitHub for Repos
    if let finalURL = finalURL {
      session.dataTaskWithURL(finalURL, completionHandler: { (data, response, error) -> Void in
        if let error = error {
          //do something with error here
        } else if let httpResponse = response as? NSHTTPURLResponse {
          println(httpResponse.statusCode)
          completion(data: data, error: nil)
        }
      }).resume()
    }

    //TODO 5 - Check for errors
    //TODO 6 - Switch for HTTP Status Code - Maybe use an enum?
  }
  //TODO - Search Users
  class func usersForSearchTerm(searchTerm : String, completion: (data : NSData?, error: String?) -> ()) {
    //Set Up Session
    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    if let token = self.sharedService.token {
      let additionalHeaders = ["Authorization" : "token \(token)"]
      config.HTTPAdditionalHeaders = additionalHeaders
    }
    let session = NSURLSession(configuration: config)
    //Has to be done everytime because Apple says so
    
    //Concatenate URL
    let queryUrl = self.sharedService.baseURL + "search/users?q=\(searchTerm)"
    let finalURL = NSURL(string: queryUrl)
    
    //Query GitHub for Repos
    if let finalURL = finalURL {
      session.dataTaskWithURL(finalURL, completionHandler: { (data, response, error) -> Void in
        if let error = error {
          //do something with error here
        } else if let httpResponse = response as? NSHTTPURLResponse {
          println(httpResponse.statusCode)
          completion(data: data, error: nil)
        }
      }).resume()
    }
  }
  
  //MARK : Download Image From Github URL
  class func downloadImageFromGitHub(url : String, completion: (image : UIImage) -> ()) {
    var imageURL = NSURL(string: url)
    
    if let url = imageURL {
      if let imageData = NSData(contentsOfURL: url),
        image = UIImage(data: imageData) {
          completion(image: image)
      }
    }
    
  }
  
  //MARK: Get Additional User Info
  class func getUserInfo(searchTerm : String, completion: (data : NSData?, error: String?) -> ()) {
    //Set Up Session
    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    if let token = self.sharedService.token {
      let additionalHeaders = ["Authorization" : "token \(token)"]
      config.HTTPAdditionalHeaders = additionalHeaders
    }
    let session = NSURLSession(configuration: config)
    //Has to be done everytime because Apple says so
    
    //Concatenate URL
    let queryUrl = self.sharedService.baseURL + "users/\(searchTerm)"
    let finalURL = NSURL(string: queryUrl)
    
    //Query GitHub for Repos
    if let finalURL = finalURL {
      session.dataTaskWithURL(finalURL, completionHandler: { (data, response, error) -> Void in
        if let error = error {
          //do something with error here
        } else if let httpResponse = response as? NSHTTPURLResponse {
          println(httpResponse.statusCode)
          completion(data: data, error: nil)
        }
      }).resume()
    }
  }
  
  //TODO - Update User Data - PATCH /user
  
  //TODO - Create New Repo - POST /user/repos
}
