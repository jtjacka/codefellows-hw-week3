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
            description = repoData["description"] as? String,
            url = repoData["url"] as? String,
          stargazersCount = repoData["stargazers_count"] as? Double,
          watchersCount = repoData["watchers_count"] as? Double,
          language = repoData["language"] as? String,
          forksCount = repoData["forks_count"] as? Double {
              
              if let repoOwner = GitHubJSONParser.ParseUserSearchData(owner){
                let newRepo = GitHubRepo(id: id, name: name, owner: repoOwner, privateRepo: privateBool, htmlURL: htmlURL, description: description, url: url, stargazersCount: stargazersCount, watchersCount: watchersCount, language: language, forksCount: forksCount)
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
  
  class func ParseUserFromSpecificUser(data: NSData) -> GitHubUser? {
    var error: NSError?
    
    if let serializedData = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error) as? [String : AnyObject] {
       return GitHubJSONParser.ParseUserSearchData(serializedData)
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
        
        if let name = userData["name"] as? String {
            let blog = userData["blog"] as? String
            let email = userData["email"] as? String
            let hireable = userData["hireable"] as? Bool
            let bio = userData["bio"] as? String
            let joinData = userData["created_at"] as? String
            let publicRepos = userData["public_repos"] as? Int
            let followers = userData["followers"] as? Int
            let following = userData["following"] as? Int
            let location = userData["location"] as? String
            
            return GitHubUser(login: login, id: id, avatarUrl: avatarUrl, gravatarId: gravatarId, url: profileURL, receivedEventsURL: receivedEventsURL, type: type, name: name, blogUrl: blog, location: location, email: email, hireable: hireable, bio: bio, joinDate: joinData, publicReposCount: publicRepos, followers: followers, following: following)
        }
        else {
          return GitHubUser(login: login, id: id, avatarUrl: avatarUrl, gravatarId: gravatarId, url: profileURL, receivedEventsURL: receivedEventsURL, type: type, name: nil, blogUrl: nil, location: nil, email: nil, hireable: nil, bio: nil, joinDate: nil, publicReposCount: nil, followers: nil, following: nil)
        }
    }
    return nil
  }
}