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
  
  let transition = ToUserDetailViewAnimationController()
  var users : [GitHubUser] = []
  var imageQueue = NSOperationQueue()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        searchBar.delegate = self
        collectionView.dataSource = self
      
      
      //Set Background to Match
      collectionView.backgroundView = BackgroundView()
      
    }
  
  override func viewWillAppear(animated: Bool) {
    navigationController?.delegate = self
  }
  
  override func viewWillDisappear(animated: Bool) {
    navigationController?.delegate = nil
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      if segue.identifier == "ShowUserDetail" {
          let destination = segue.destinationViewController as! UserDetailTableViewController
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
    
    //Cell Tagging
    cell.tag++
    let tag = cell.tag
    
    let user = users[indexPath.row]
    
    cell.profileNameLabel.text = user.login
    
    cell.profileImage.image = nil
    println(user.avatarUrl)
    imageQueue.addOperationWithBlock { () -> Void in
      GithubService.downloadImageFromGitHub(user.avatarUrl, completion: { (image) -> () in
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          if cell.tag == tag {
            cell.profileImage.image = image
          }
        })
    })
}
    
    return cell
  }
  
}

//MARK: Extend UICollectionViewDelegate
extension UserSearchViewController : UICollectionViewDelegate {
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier("ShowUserDetail", sender: self)
  }
}

//MARK: Extend UINavigationControllerDelegate
extension UserSearchViewController : UINavigationControllerDelegate {
  func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return toVC is UserDetailTableViewController ? ToUserDetailViewAnimationController() : nil
  }
}