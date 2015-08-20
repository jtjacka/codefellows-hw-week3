//
//  ToUserDetailViewController.swift
//  
//
//  Created by Jeffrey Jacka on 8/20/15.
//
//

import UIKit

class ToUserDetailViewController: NSObject {
  let kAnimatonDuration = 0.4
  
   
}

//MARK: Extend UIViewControllerAnimatedTransitioning
extension ToUserDetailViewController : UIViewControllerAnimatedTransitioning {
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return kAnimatonDuration
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    
  }
  
}