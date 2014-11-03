//
//  SnapDynamic.swift
//  HomeWork
//
//  Created by RainSea on 11/1/14.
//  Copyright (c) 2014 RainSea. All rights reserved.
//

import UIKit

class SnapDynamic: UIViewController {

    var grayBox: UIView?
    var animator: UIDynamicAnimator?
    var collision: UICollisionBehavior?
    var push: UIPushBehavior?
    var snap: UISnapBehavior?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        grayBox = UIView(frame: CGRectMake(CGRectGetMidX(self.view.bounds) - 50, 300, 100, 100))
        grayBox!.backgroundColor = UIColor.grayColor()
        grayBox!.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/8))
        self.view.addSubview(grayBox!)
        
        //init animator
        animator = UIDynamicAnimator(referenceView: self.view)
        
        //init collision
        collision = UICollisionBehavior(items: [grayBox!])
        collision!.translatesReferenceBoundsIntoBoundary = true
        self.animator!.addBehavior(collision)
        
        //init push
        push = UIPushBehavior(items: [grayBox!], mode: UIPushBehaviorMode.Instantaneous)
        push!.setAngle(CGFloat(M_PI / -2), magnitude: 5)
        self.animator!.addBehavior(push)
        
        
        var tap = UITapGestureRecognizer(target: self, action: "onTap:")
        self.grayBox!.addGestureRecognizer(tap)
        
        snap = UISnapBehavior(item: self.grayBox!, snapToPoint: CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds)))
        var pan = UIPanGestureRecognizer(target: self, action: "onPan:")
        self.grayBox!.addGestureRecognizer(pan)
    }
    
    func onTap(tap: UITapGestureRecognizer){
        self.animator!.removeBehavior(snap)
        self.animator!.removeBehavior(push)
        self.animator!.removeBehavior(collision)
        push!.active = false
        push!.setAngle(CGFloat(M_PI / -2), magnitude: 10)
        push!.active = true
    }
    func onPan(pan: UIPanGestureRecognizer){
        var location = pan.locationInView(self.view)
        self.animator!.removeAllBehaviors()
        if pan.state == UIGestureRecognizerState.Began {
            
        self.grayBox!.center = pan.locationOfTouch(0, inView: self.view);
        }
        
        if pan.state == UIGestureRecognizerState.Changed {
            self.grayBox!.center = pan.locationOfTouch(0, inView: self.view)
        }
        
        if pan.state == UIGestureRecognizerState.Ended {
            self.animator!.addBehavior(snap);
            
        }
        
    }

}
