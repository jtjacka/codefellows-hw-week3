//
//  GitHubRepo.swift
//  GithubClient
//
//  Created by Jeffrey Jacka on 8/18/15.
//  Copyright (c) 2015 Jeffrey Jacka. All rights reserved.
//

import Foundation

struct GitHubRepo {
  let id : Double
  let name : String
  let owner : GitHubUser
  let privateRepo : Bool
  let htmlURL : String
  let description : String
//  let fork : Bool
  let url : String
//  let createdAt : String
//  let updatedAt : String
//  let pushedAt : String
//  let homepage : String
//  let size : Double
  let stargazersCount : Double
  let watchersCount : Double
  let language : String
  let forksCount : Double
//  let openIssuesCount : Double
//  let masterBranch : String
//  let defaultBranch : String
//  let score : String
}

