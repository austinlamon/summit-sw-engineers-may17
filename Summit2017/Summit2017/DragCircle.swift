//
//  DragCircle.swift
//  Summit2017
//
//  Created by Lamon, Austin on 5/22/17.
//  Copyright © 2017 Austin. All rights reserved.
//

import UIKit

extension ViewController {
    public func dragCircle(gesture: UIPanGestureRecognizer) {
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
