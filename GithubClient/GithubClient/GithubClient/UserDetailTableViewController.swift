//
//  UserDetailTableViewController.swift
//  
//
//  Created by Jeffrey Jacka on 8/23/15.
//
//

import UIKit

class UserDetailTableViewController: UITableViewController {
  
  //Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileUsernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var hireableLabel: UILabel!
    @IBOutlet weak var joinDateLabel: UILabel!
    @IBOutlet weak var publicRepos: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
  
  //Properties
  var user : GitHubUser?

    override func viewDidLoad() {
        super.viewDidLoad()
      
      //Assign Profile Image
      if let image = user?.avatarUrl {
        GithubService.downloadImageFromGitHub(image, completion: { (image) -> () in
          self.profileImage.image = image
        })
      }


      
      //Assign TableView Background
      tableView.backgroundView = BackgroundView()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        //Assign the Rest of the TableView Data
        if let user = user {
            GithubService.getUserInfo(user.login) { (data, error) -> () in
                if let error = error {
                    println(error)
                }
                
                if let returnData = data {
                    let user = GitHubJSONParser.ParseUserFromSpecificUser(returnData)
                    
                    if let currentUser = user{
                        self.user = currentUser
                        
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            //Assign Data
                            self.profileUsernameLabel.text = currentUser.login
                            self.nameLabel.text = currentUser.name
                            self.locationLabel.text = currentUser.location
                            self.emailLabel.text = currentUser.email
                            self.websiteLabel.text = currentUser.blogUrl
                            self.joinDateLabel.text = currentUser.joinDate
                            
                            if let repos = currentUser.publicReposCount {
                                self.publicRepos.text = String(repos)
                            }

                            if let followers = currentUser.followers {
                                self.followers.text = String(followers)
                            }
                            
                            if let following = currentUser.following {
                                self.followingLabel.text = String(following)
                            }
                            
                            self.bioLabel.text = currentUser.bio
                            
                            
                            if let hirable = currentUser.hireable {
                                self.hireableLabel.text = "Yes"
                            } else {
                                self.hireableLabel.text = "No"
                            }
                            
                            self.tableView.reloadData()
                        })
                        
                        
                        
                        
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 11
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
