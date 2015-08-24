//
//  GitHubUser.swift
//  GithubClient
//
//  Created by Jeffrey Jacka on 8/18/15.
//  Copyright (c) 2015 Jeffrey Jacka. All rights reserved.
//

import Foundation

struct GitHubUser {
  let login : String
  let id : Double
  let avatarUrl : String
  let gravatarId : String
  let url : String
  let receivedEventsURL : String
  let type : String
  //Requires full api call
  let name : String?
  let blogUrl : String?
  let location : String?
  let email : String?
  let hireable : Bool?
  let bio : String?
  let joinDate : String?
  let publicReposCount : Int?
  let followers : Int?
  let following : Int?
}



