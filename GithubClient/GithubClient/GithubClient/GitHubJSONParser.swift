//
//  GitHubJSONParser.swift
//  GithubClient
//
//  Created by Jeffrey Jacka on 8/18/15.
//  Copyright (c) 2015 Jeffrey Jacka. All rights reserved.
//

import Foundation

class GitHubJSONParser {
  class func ParseRepoSearchData(data : NSData) -> [GitHubRepo] {
    var gitHubRepos : [GitHubRepo] = []
    
    
    var error : NSError?
    
    if let repoReturn = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error) as? [String : AnyObject]{
      if let repoArray = repoReturn["items"] as? [[String : AnyObject]] {
        
        for repoData in repoArray {
          if let id = repoData["id"] as? Double,
            name = repoData["name"] as? String,
            fullName = repoData["full_name"] as? String,
            owner = repoData["owner"] as? [String : AnyObject],
            privateBool = repoData["private"] as? Bool,
            htmlURL = repoData["html_url"] as? String,
            description = repoData["description"] as? String {
              
              if let repoOwner = GitHubJSONParser.ParseUserSearchData(owner){
                let newRepo = GitHubRepo(id: id, name: name, owner: repoOwner, privateRepo: privateBool, htmlURL: htmlURL, description: description)
                gitHubRepos.append(newRepo)
              }
          }
          
        }
        
        
      }
      
    }
    return gitHubRepos
  }
  
  class func ParseUserDataFromNSData(data : NSData) -> [GitHubUser] {
    var error : NSError?
    var newUsers : [GitHubUser] = []
    
    if let serializedData = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error) as? [String : AnyObject] {
      
      if let userArray = serializedData["items"] as? [[String:AnyObject]] {
        
        for user in userArray {
          if let user = GitHubJSONParser.ParseUserSearchData(user) {
            newUsers.append(user)
          }
        }
      }
    }
    
    return newUsers
  }
  
  
  class func ParseUserSearchData(userData : [String : AnyObject]) -> GitHubUser? {
    
    if let login = userData["login"] as? String,
      id = userData["id"] as? Double,
      avatarUrl = userData["avatar_url"] as? String,
      gravatarId = userData["gravatar_id"] as? String,
      profileURL = userData["url"] as? String,
      receivedEventsURL = userData["received_events_url"] as? String,
      type = userData["type"] as? String {
        
        return GitHubUser(login: login, id: id, avatarUrl: avatarUrl, gravatarId: gravatarId, url: profileURL, receivedEventsURL: receivedEventsURL, type: type)
        
    }
    return nil
  }
}