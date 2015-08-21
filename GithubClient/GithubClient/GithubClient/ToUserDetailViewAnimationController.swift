//
//  ToUserDetailViewController.swift
//  
//
//  Created by Jeffrey Jacka on 8/20/15.
//
//

import UIKit

class ToUserDetailViewAnimationController: NSObject {
  let kAnimatonDuration = 0.4
  
   
}

//MARK: Extend UIViewControllerAnimatedTransitioning
extension ToUserDetailViewAnimationController : UIViewControllerAnimatedTransitioning {
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return kAnimatonDuration
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
      //This is where the animation goes
    
      if let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? UserSearchViewController,
        toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? UserDetailViewController {
          
          println("First set of if lets in animation")
          
          //containerView has fromVC's view already installed
          let containerView = transitionContext.containerView()
          
          //Add new view hidden
          toVC.view.alpha = 0
          containerView.addSubview(toVC.view)
          
          let indexPath = fromVC.collectionView.indexPathsForSelectedItems().first as! NSIndexPath
          let userCell = fromVC.collectionView.cellForItemAtIndexPath(indexPath) as! UserCell
          let snapShot = userCell.profileImage.snapshotViewAfterScreenUpdates(false)
          
          //Find location of snapshot
          snapShot.frame = containerView.convertRect(userCell.profileImage.frame, fromCoordinateSpace: userCell.profileImage.superview!)
          
          //Cover old cell with snapshot and hide
          containerView.addSubview(snapShot)
          userCell.hidden = true
          
          
          //Force AutoLayout to calculate layout for view
          toVC.view.layoutIfNeeded()
          
          //Temporarily hide destination image
          toVC.profileImage.hidden = true
          
          //Find Location of Destination Frame
          let destinationFrame = containerView.convertRect(toVC.profileImage.frame, fromCoordinateSpace: toVC.profileImage.superview!)
          
          
          //Animate
          UIView.animateWithDuration(0.4, animations: { () -> Void in
            snapShot.frame = destinationFrame
            toVC.view.alpha = 1
            }, completion: { (animationCompletion) -> Void in
              //Unhide for going back
              userCell.hidden = false
              toVC.profileImage.hidden = false
              snapShot.removeFromSuperview()
              
              //Let Context know the animation has completely succesfully
              animationCompletion ? transitionContext.completeTransition(animationCompletion) : transitionContext.completeTransition(animationCompletion)
          })
          
    }
  }
  
}