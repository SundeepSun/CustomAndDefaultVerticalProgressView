//
//  VerticalProgressView.swift
//  VerticalProgressView
//
//  Created by Shivakumar, Sundeep on 3/29/17.
//  Copyright © 2017 com.Sundeep.Learning. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class VerticalProgressView : UIView {
    @IBInspectable public var animationDuration = 0.95
    var previousProgress : Float = 0.0
    @IBInspectable public var progress:Float {
        get {
            return self.previousProgress
        }
        set {
            self.setProgress(progress: newValue, animated: self.animationDuration > 0.0)
        }
    }
    public var filledView:CALayer?
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        let filledHeight = rect.size.height * CGFloat(self.previousProgress)
        let y = self.frame.size.height - filledHeight
        self.filledView!.frame = CGRect(x: 0, y: y, width: rect.size.width, height: rect.size.height)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        if self.filledView == nil {
            self.filledView = CALayer()
            self.filledView!.backgroundColor = UIColor.green.cgColor
            self.layer.addSublayer(filledView!)
        }
        self.filledView!.frame = self.bounds
        self.filledView!.frame.origin.y = self.getPosition()
    }
    
    public override func prepareForInterfaceBuilder() {
        self.previousProgress = progress
        if self.previousProgress < 0 { previousProgress = 0 }
        else if(self.previousProgress > 1) { previousProgress = 1}
    }
    
    public func setProgress(progress:Float,animated: Bool){
        
        var value = progress
        if (value < 0.0){
            value = 0.0
        }
        else if(value > 1.0){
            value = 1.0
        }
        self.previousProgress = value
        setFilledProgress(position: getPosition(),animated:animated)
    }
    
    fileprivate func setFilledProgress(position:CGFloat, animated:Bool) {
        if self.filledView == nil { return }
        //animated
        let duration: TimeInterval = animated ? self.animationDuration : 0;
        CATransaction.begin()
        CATransaction.setAnimationDuration(duration)
        self.filledView!.frame.origin.y = position
        CATransaction.commit()
    }
    
    fileprivate func getPosition() -> CGFloat {
        let filledHeight = self.frame.size.height * CGFloat(self.previousProgress)
        let position = self.frame.size.height - filledHeight
        return position
    }
}
