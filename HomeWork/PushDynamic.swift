//
//  PushDynamic.swift
//  HomeWork
//
//  Created by RainSea on 11/1/14.
//  Copyright (c) 2014 RainSea. All rights reserved.
//

import UIKit

class PushDynamic: UIViewController {
    var redBox: UIView?
    var animator: UIDynamicAnimator?
    var collision: UICollisionBehavior?
    var push: UIPushBehavior?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        redBox = UIView(frame: CGRectMake(CGRectGetMidX(self.view.bounds) - 50, 300, 100, 100))
        redBox!.backgroundColor = UIColor.redColor()
        redBox!.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/8))
        self.view.addSubview(redBox!)
        
        //init animator
        animator = UIDynamicAnimator(referenceView: self.view)
        
        //init collision
        collision = UICollisionBehavior(items: [redBox!])
        collision!.translatesReferenceBoundsIntoBoundary = true
        self.animator!.addBehavior(collision)
        
        //init push
        push = UIPushBehavior(items: [redBox!], mode: UIPushBehaviorMode.Instantaneous)
        push!.setAngle(CGFloat(M_PI / -2), magnitude: 5)
        self.animator!.addBehavior(push)
        var tap = UITapGestureRecognizer(target: self, action: "onTap:")
        self.redBox!.addGestureRecognizer(tap)
    }

    func onTap(tap: UITapGestureRecognizer){
        push!.active = false
        push!.setAngle(CGFloat(M_PI / -2), magnitude: 10)
        push!.active = true
    }
    

}
