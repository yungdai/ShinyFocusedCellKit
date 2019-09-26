//
//  ShinyFocusedCell.swift
//  ShinyFocusedCellKit
//
//  Created by Yung Dai on 2019-09-26.
//  Copyright © 2019 None. All rights reserved.
//

import UIKit

typealias FractionRotation = (fractionPoint: CGPoint, rotationTransform: CATransform3D)

public protocol ShinyFocusedCell: UICollectionViewCell {

	var dimView: UIView! { get set }
	var spotlight: RadialGradientView! { get set }
}

extension ShinyFocusedCell {
	
	public func setupShinyFocusedCell() {

		if dimView != nil {
			dimView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.15)
			dimView.alpha = 0
		} else {
			print("DimView was nil")
		}
		
		if spotlight != nil {
			spotlight.alpha = 0
			spotlight.backgroundColor = UIColor.clear
		} else {
			print("Spotlight was nil")
		}
	}
	
	public func setSpotlight(innerColor: UIColor, outerColor: UIColor) {
		
		spotlight.innerColor = innerColor
		spotlight.outerColor = outerColor
	}
	
	internal func animateSpotlightOnXYAxis(fractionPoint: CGPoint) {
		
		let halfWidth = bounds.width / 2
		
		// make sure the the spotlight is fully visible when the cell is tilting
        spotlight.alpha = 1
        dimView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        var fractionX: CGFloat = 0.0
        var fractionY: CGFloat = 0.0

        // tilt right
        if fractionPoint.x < 1 {
            dimView.alpha = 1 - fractionPoint.x
            fractionX =  -(halfWidth * (1 - fractionPoint.x))
        }
        
        // tilt left
        if fractionPoint.x > 1 {
            dimView.alpha = fractionPoint.x - 1
            fractionX = (halfWidth * (fractionPoint.x  - 1))
        }
        
        // tilt up
        if fractionPoint.y < 1 {
            
            if fractionPoint.x < fractionPoint.y {
                dimView.alpha = 1 - fractionPoint.y
            }

            fractionY = (halfWidth * (1 - fractionPoint.y))
        }
        
        // tilt down
        if fractionPoint.y > 1 {
            
            if fractionPoint.x > fractionPoint.y {
                dimView.alpha = fractionPoint.y - 1
            }
            
            fractionY = -(halfWidth * (fractionPoint.y  - 1))
        }
        
        spotlight.transform = CGAffineTransform(translationX: fractionX, y: fractionY)
	}
	
	internal func animateSpotlight(fraction: CGFloat) {
		
		let centerX = bounds.width / 2
		
        // make sure the the spotlight is fully visible when the cell is tilting
        spotlight.alpha = 1
        dimView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // tilt right
        if fraction < 1 {
            dimView.alpha = 1 - fraction
            spotlight.transform = CGAffineTransform(translationX: -(centerX * (1 - fraction)), y: 0)
        }
        
        // tilt left
        if fraction > 1 {
            dimView.alpha = fraction - 1
            spotlight.transform = CGAffineTransform(translationX: (centerX * (fraction  - 1)), y: 0)
        }
	}
	
	internal func tilt(rotationTransform: CATransform3D) {
		layer.transform = rotationTransform
	}
}




