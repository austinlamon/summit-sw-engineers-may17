//
//  ViewController.swift
//  Summit2017
//
//  Created by Lamon, Austin on 1/8/17.
//  Copyright © 2017 Austin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // this records our circle's center for use as an offset while dragging
    var circleCenter: CGPoint!
    // We will attach various animations to this in response to drag events
    var circleAnimator: UIViewPropertyAnimator?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add a circlular view
        let circle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
        circle.center = self.view.center
        circle.layer.cornerRadius = 50.0
        circle.backgroundColor = UIColor.blue

        // Add pan gesture recognizer to circle
        circle.addGestureRecognizer(UIPanGestureRecognizer(target: self,
                                                           action: #selector(self.dragCircle)))

        self.view.addSubview(circle)
    }

    func dragCircle(gesture: UIPanGestureRecognizer) {
        let target = gesture.view!

        switch gesture.state {
        case .began:
            if circleAnimator != nil && circleAnimator!.isRunning {
                circleAnimator!.stopAnimation(false)
            }
            circleCenter = target.center
        case .changed:
            let translation = gesture.translation(in: self.view)
            target.center = CGPoint(x: circleCenter!.x + translation.x,
                                    y: circleCenter!.y + translation.y)
        case .ended:
            let v = gesture.velocity(in: target)
            let velocity = CGVector(dx: v.x / 500, dy: v.y / 500)
            let springParameters = UISpringTimingParameters(mass: 2.5,
                                                            stiffness: 70,
                                                            damping: 55,
                                                            initialVelocity: velocity)
            circleAnimator = UIViewPropertyAnimator(duration: 0.0,
                                                    timingParameters: springParameters)

            circleAnimator!.addAnimations({
                target.center = self.view.center
            })
            circleAnimator!.startAnimation()
        default: break
        }
    }
}
