//
//  RadialGradientView.swift
//  ShinyFocusedCellKit
//
//  Created by Yung Dai on 2019-09-26.
//  Copyright © 2019 None. All rights reserved.
//

import UIKit

let spotlightString = "spotlight"

public class RadialGradientView: UIView {

	var gradientLayer = RadialGradientLayer()

    override public func draw(_ rect: CGRect) {
        super.draw(rect)
		
		self.layer.sublayers?.removeAll()

		gradientLayer.setLayerToCenter(of: bounds)
		gradientLayer.bounds = bounds
		gradientLayer.frame = bounds
		self.layer.addSublayer(gradientLayer)
	}
}

public extension RadialGradientView {
	
	func resetSpotlight() {
		self.transform = .identity
		self.alpha = 0
	}
	
	func setSpotlight(innerColor: UIColor?, outerColor: UIColor?) {
		gradientLayer.set(innerColor: innerColor, outerColor: outerColor)
	}

	internal func animateSpotlightOnXYAxis(fractionPoint: CGPoint) {

		let halfWidth = bounds.width / 2

		// make sure the the spotlight is fully visible when the cell is tilting

		self.alpha = 1

        var fractionX: CGFloat = 0.0
        var fractionY: CGFloat = 0.0

        // tilt right
        if fractionPoint.x < 1 {
            fractionX =  -(halfWidth * (1 - fractionPoint.x))
        }

        // tilt left
        if fractionPoint.x > 1 {
            fractionX = (halfWidth * (fractionPoint.x  - 1))
        }

        // tilt up
        if fractionPoint.y < 1 {
            fractionY = (halfWidth * (1 - fractionPoint.y))
        }

        // tilt down
        if fractionPoint.y > 1 {
            fractionY = -(halfWidth * (fractionPoint.y  - 1))
        }

		self.transform = CGAffineTransform.init(translationX: fractionX, y: fractionY)
	}
	
	internal func animateSpotlightOnXAxis(fraction: CGFloat) {

		let centerX = frame.width / 2

        // make sure the the spotlight is fully visible when the cell is tilting
		self.alpha = 1

        // tilt right
        if fraction < 1 {
			self.transform = CGAffineTransform.init(translationX: -(centerX * (1 - fraction)), y: 0.0)
        }

        // tilt left
        if fraction > 1 {
			self.transform =  CGAffineTransform.init(translationX: (centerX * (fraction  - 1)), y: 0.0)
        }
	}
}
