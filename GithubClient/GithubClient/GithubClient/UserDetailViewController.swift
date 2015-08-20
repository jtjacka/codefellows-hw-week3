//
//  UserDetailViewController.swift
//  
//
//  Created by Jeffrey Jacka on 8/20/15.
//
//

import UIKit

class UserDetailViewController: UIViewController {

  @IBOutlet weak var profileImage: UIImageView!
  
  var user : GitHubUser?
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      if let image = user?.avatarUrl {
        GithubService.downloadImageFromGitHub(image, completion: { (image) -> () in
          self.profileImage.image = image
        })
      }

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
