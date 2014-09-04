//
//  ViewController.swift
//  Picnic_1
//
//  Created by Maggie Yunjie Bi on 9/3/14.
//  Copyright (c) 2014 daapr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var isBugDead = false
    
    @IBOutlet var basketTop: UIImageView!
                            
    @IBOutlet var basketBottom: UIImageView!
    
    @IBOutlet var fabricTop: UIImageView!
    
    @IBOutlet var fabricBottom: UIImageView!
    
    @IBOutlet weak var bug: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.7, delay: 1.0, options: .CurveEaseOut, animations: {
            var basketTopFrame = self.basketTop.frame
            basketTopFrame.origin.y -= basketTopFrame.size.height
            
            var basketBottomFrame = self.basketBottom.frame
            basketBottomFrame.origin.y += basketBottomFrame.size.height
            
            self.basketTop.frame = basketTopFrame
            self.basketBottom.frame = basketBottomFrame
            }, completion: { finished in
                println("Basket doors opened!")
        })
        
        UIView.animateWithDuration(1.0, delay: 1.2, options: .CurveEaseOut, animations: {
            var fabricTopFrame = self.fabricTop.frame
            fabricTopFrame.origin.y -= fabricTopFrame.size.height
            
            var fabricBottomFrame = self.fabricBottom.frame
            fabricBottomFrame.origin.y += fabricBottomFrame.size.height
            
            self.fabricTop.frame = fabricTopFrame
            self.fabricBottom.frame = fabricBottomFrame
            }, completion: { finished in
                println("Napkins opened!")
        })
        
        moveBugLeft()
        
        let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        view.addGestureRecognizer(tap)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func moveBugLeft(){
        if isBugDead{return}
        
        UIView.animateWithDuration(1.0, delay: 2.0,
            options: .CurveEaseInOut | .AllowUserInteraction,
            animations: {self.bug.center = CGPoint(x:75, y:200)},
            completion: {finished in println("Bug moved left!")
        self.faceBugRight()})
    }
    
    func faceBugRight() {
        if isBugDead { return }
        
        UIView.animateWithDuration(1.0,
            delay: 0.0,
            options: .CurveEaseInOut | .AllowUserInteraction,
            animations: {
                self.bug.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
            },
            completion: { finished in
                println("Bug faced right!")
                self.moveBugRight()
        })
    }
    
    func moveBugRight() {
        if isBugDead { return }
        
        UIView.animateWithDuration(1.0,
            delay: 2.0,
            options: .CurveEaseInOut | .AllowUserInteraction,
            animations: {
                self.bug.center = CGPoint(x: 230, y: 250)
            },
            completion: { finished in
                println("Bug moved right!")
                self.faceBugLeft()
        })
    }
    
    func faceBugLeft() {
        if isBugDead { return }
        
        UIView.animateWithDuration(1.0,
            delay: 0.0,
            options: .CurveEaseInOut | .AllowUserInteraction,
            animations: {
                self.bug.transform = CGAffineTransformMakeRotation(0.0)
            },
            completion: { finished in
                println("Bug faced left!")
                self.moveBugLeft()
        })
    }
    
    func handleTap(gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.locationInView(bug.superview)
        if bug.layer.presentationLayer().frame.contains(tapLocation) {
            println("Bug tapped!")
            // add bug-squashing code here
            
            if isBugDead { return }
            isBugDead = true
            UIView.animateWithDuration(0.7, delay: 0.0, options: .CurveEaseOut, animations: {
                self.bug.transform = CGAffineTransformMakeScale(1.25, 0.75)
                }, completion: { finished in
                    UIView.animateWithDuration(2.0, delay: 2.0, options: nil, animations: {
                        self.bug.alpha = 0.0
                        }, completion: { finished in
                            self.bug.removeFromSuperview()
                    })
            })
        } else {
            println("Bug not tapped!")
        }
    }
    
}

