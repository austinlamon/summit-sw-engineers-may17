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

        self.view.addSubview(circle)

        // Add pan gesture recognizer to circle
//        circle.addGestureRecognizer(UIPanGestureRecognizer(target: self,
//                                                           action: #selector(self.dragCircle)))
    }
}
