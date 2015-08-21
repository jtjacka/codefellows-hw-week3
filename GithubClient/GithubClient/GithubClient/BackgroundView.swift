//
//  BackgroundView.swift
//  
//
//  Created by Jeffrey Jacka on 8/20/15.
//
//
import UIKit

//Code borrowed from Team Treehouse Stormy Videos
class BackgroundView: UIView {
  
  
  // Only override drawRect: if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  override func drawRect(rect: CGRect) {
    // Background View
    
    //// Color Declarations
    let lightPurple: UIColor = UIColor(red: 72/255.0, green: 39/255.0, blue: 120/255.0, alpha: 1.000)
    let darkPurple: UIColor = UIColor(red: 137/255.0, green: 39/255.0, blue: 147/255.0, alpha: 1.000)
    
    
    let context = UIGraphicsGetCurrentContext()
    
    //// Gradient Declarations
    let purpleGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [lightPurple.CGColor, darkPurple.CGColor], [0, 1])
    
    //// Background Drawing
    let backgroundPath = UIBezierPath(rect: CGRectMake(0, 0, self.frame.width, self.frame.height))
    CGContextSaveGState(context)
    backgroundPath.addClip()
    CGContextDrawLinearGradient(context, purpleGradient,
      CGPointMake(160, 0),
      CGPointMake(160, 568),
      UInt32(kCGGradientDrawsBeforeStartLocation) | UInt32(kCGGradientDrawsAfterEndLocation))
    CGContextRestoreGState(context)
  }
  
  
}
