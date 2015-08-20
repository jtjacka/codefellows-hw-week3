//
//  GitHubSearchViewController.swift
//  
//
//  Created by Jeffrey Jacka on 8/18/15.
//
//

import UIKit

class GitHubSearchViewController: UIViewController {
  //Outlets
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  
  var repoArray : [GitHubRepo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
      
      // Set table view's background view property
      tableView.backgroundView = BackgroundView()

        // Do any additional setup after loading the view.
      searchBar.delegate = self
      tableView.dataSource = self
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
extension GitHubSearchViewController : UISearchBarDelegate {
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    
    GithubService.repositoriesForSearchTerm(searchBar.text) { (data, error) -> () in
      //do something
      if let searchData = data {
        let repoData = GitHubJSONParser.ParseRepoSearchData(searchData)
        //Assign and Reload New Data
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          self.repoArray = repoData
          self.tableView.reloadData()
        })

      }
    }
  }
}

//MARK: Extend UITableViewDatasource
extension GitHubSearchViewController : UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return repoArray.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("SearchCell", forIndexPath: indexPath) as! UITableViewCell
    
    let repo = repoArray[indexPath.row]
    
    cell.textLabel?.text = repo.name
    cell.detailTextLabel?.text = repo.description
    
    
    return cell
  }
}
