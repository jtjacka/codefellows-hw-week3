//
//  GitHubJSONParser.swift
//  GithubClient
//
//  Created by Jeffrey Jacka on 8/18/15.
//  Copyright (c) 2015 Jeffrey Jacka. All rights reserved.
//

import Foundation

class GitHubJSONParser {
  class func ParseRepoSearchData(data : NSData) -> GitHubRepo? {
    
    var error : NSError?
    
    if let repoData = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error) as? [String : AnyObject]{
      if let id = repoData["id"] as? Double,
        name = repoData["name"] as? String,
        fullName = repoData["full_name"] as? String,
        owner = repoData["owner"] as? [String : AnyObject],
        privateBool = repoData["private"] as? Bool,
        htmlURL = repoData["html_url"] as? String,
        description = repoData["description"] as? String {
          
          if let repoOwner = GitHubJSONParser.ParseUserSearchData(owner){
            return GitHubRepo(id: id, name: name, owner: repoOwner, privateRepo: privateBool, htmlURL: htmlURL, description: description)
          }
      }
    }
    return nil
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