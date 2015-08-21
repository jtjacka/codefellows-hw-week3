//
//  WebViewController.swift
//  
//
//  Created by Jeffrey Jacka on 8/20/15.
//
//

import UIKit
import WebKit


class WebViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
      let webView = WKWebView(frame: view.frame)
      view.addSubview(webView)
      
      //TODO - Create URL Request
      //TODO - Load Request

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
