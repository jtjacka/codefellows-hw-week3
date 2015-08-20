//
//  UserSearchViewController.swift
//  
//
//  Created by Jeffrey Jacka on 8/19/15.
//
//

import UIKit

class UserSearchViewController: UIViewController {

  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var collectionView: UICollectionView!
  
  var users : [GitHubUser] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
      

      
        searchBar.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      if segue.identifier == "ShowUserDetail" {
          let destination = segue.destinationViewController as! UserDetailViewController
          let cell = sender as! UserCell
          let indexPath = collectionView.indexPathForCell(cell)
        
          destination.user = users[indexPath!.row]
          destination.profileImage = cell.profileImage
        
        
      }
    }

}

//MARK: Extend UISearchBarDelegate
extension UserSearchViewController : UISearchBarDelegate {
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    
    GithubService.usersForSearchTerm(searchBar.text, completion: { (data, error) -> () in
      if let searchData = data {
        
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          self.users = GitHubJSONParser.ParseUserDataFromNSData(searchData)
          self.collectionView.reloadData()
        })

      }
     })
  }
}

//MARK: Extend UICollectionViewDataSource
extension UserSearchViewController : UICollectionViewDataSource {
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return users.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("UserCell", forIndexPath: indexPath) as! UserCell
    
    let user = users[indexPath.row]
    
    println(user.avatarUrl)
    
    GithubService.downloadImageFromGitHub(user.avatarUrl, completion: { (image) -> () in
      cell.profileImage.image = image
    })
    
    return cell
  }
  
}

//MARK: Extend UICollectionViewDelegate
extension UserSearchViewController : UICollectionViewDelegate {
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier("ShowUserDetail", sender: self)
  }
}
