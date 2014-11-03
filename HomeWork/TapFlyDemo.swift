//
//  TapFlyDemo.swift
//  HomeWork
//
//  Created by RainSea on 11/1/14.
//  Copyright (c) 2014 RainSea. All rights reserved.
//

import UIKit

class TapFlyDemo: UIViewController {
    var greenBox: UIView?
    var animator: UIDynamicAnimator?
    var gravity: UIGravityBehavior?
    var collision: UICollisionBehavior?
    var panGesture: UIPanGestureRecognizer?
    var attach: UIAttachmentBehavior?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.greenBox = UIView()
        greenBox!.backgroundColor = UIColor.blueColor()
        greenBox!.frame = CGRectMake(CGRectGetMidX(self.view.frame) - 50, CGRectGetMidY(self.view.frame) - 50, 100,100)
        self.view.addSubview(greenBox!)
//        greenBox!.multipleTouchEnabled = true
//        greenBox!.userInteractionEnabled = true
        
        self.animator = UIDynamicAnimator(referenceView: self.view)
        self.gravity = UIGravityBehavior(items: [greenBox!])
        self.animator!.addBehavior(gravity!)
        
        collision = UICollisionBehavior(items: [greenBox!])
        collision!.translatesReferenceBoundsIntoBoundary = true
        self.animator!.addBehavior(collision!)
        
        panGesture = UIPanGestureRecognizer(target: self, action: "panning:")
        self.greenBox!.addGestureRecognizer(panGesture!)
        
    }
    func panning(pan: UIPanGestureRecognizer) {
//        println("My box is panning")
        var location = pan.locationInView(self.view)
        var tapLocation = pan.locationInView(self.greenBox!)
        if pan.state == UIGestureRecognizerState.Began {
            self.animator!.removeAllBehaviors()
            
            //offset
            var offset = UIOffsetMake(tapLocation.x - CGRectGetMidX(self.greenBox!.bounds), tapLocation.y - CGRectGetMidY(self.greenBox!.bounds))
            attach = UIAttachmentBehavior(item: greenBox!, offsetFromCenter: offset, attachedToAnchor: location)
            greenBox!.center = location
            self.animator!.addBehavior(attach)
        
        } else if pan.state == UIGestureRecognizerState.Changed {
           attach!.anchorPoint = location
        
        } else if pan.state == UIGestureRecognizerState.Ended {
            var itemBehavior = UIDynamicItemBehavior(items: [greenBox!])
            itemBehavior.addLinearVelocity(pan.velocityInView(self.view), forItem: self.greenBox!)
            itemBehavior.angularResistance = 0
            //do dan hoi
            itemBehavior.elasticity = 0.9
            self.animator!.addBehavior(itemBehavior)
            self.animator!.removeBehavior(attach!)
//            self.animator!.addBehavior(attach!)
            self.animator!.addBehavior(gravity)
            self.animator!.addBehavior(collision)
        }
    }
    
}
