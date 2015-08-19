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
  
  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
    
  }
}
