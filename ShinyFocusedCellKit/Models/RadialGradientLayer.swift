//
//  RadialGradientLayer.swift
//  ShinyFocusedCellKit
//
//  Created by Yung Dai on 2019-09-27.
//  Copyright © 2019 None. All rights reserved.
//

import UIKit

public class RadialGradientLayer: CAGradientLayer {
	
	public var innerColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.9008819018)
	public var outerColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
	
	required public override init() {
		super.init()
		needsDisplayOnBoundsChange = true
	}

	override public init(layer: Any) {
		super.init(layer: layer)
	}
	
	required public init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	public convenience init(rect: CGRect, name: String) {
		self.init()
		bounds = rect
		setLayerToCenter(of: rect)
		self.name = name
	}
	
	public override func draw(in ctx: CGContext) {
		
		self.backgroundColor = UIColor.clear.cgColor
		
		// save context
		ctx.saveGState()

		let colors = [innerColor.cgColor, outerColor.cgColor] as CFArray
		let endRadius = min(bounds.width, bounds.height) / 2
		let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
		let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil)
		ctx.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: endRadius, options: .drawsBeforeStartLocation)
		
		ctx.restoreGState()
	}
	
	public func set(innerColor: UIColor?, outerColor: UIColor?)  {
		
		if let innerColor = innerColor {
			self.innerColor = innerColor
		}
		
		if let outerColor = outerColor {
			self.outerColor = outerColor
		}
	}
	
	static func makeSpotlightGradient(rect: CGRect) -> RadialGradientLayer {

		let spotlight = RadialGradientLayer(rect: rect, name: spotlightString)

		spotlight.backgroundColor = UIColor.clear.cgColor
		spotlight.opacity = 0
		return spotlight
	}
}

public extension RadialGradientLayer {
	
	internal func animateSpotlightOnXYAxis(fractionPoint: CGPoint) {

		let halfWidth = bounds.width / 2

		// make sure the the spotlight is fully visible when the cell is tilting

		self.opacity = 1

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

		self.transform = CATransform3DTranslate(self.transform, fractionX, fractionY, 0.0)
	}
	
	internal func animateSpotlightOnXAxis(fraction: CGFloat) {

		let centerX = bounds.width / 2

        // make sure the the spotlight is fully visible when the cell is tilting
		self.opacity = 1

        // tilt right
        if fraction < 1 {
			self.transform = CATransform3DTranslate(self.transform, -(centerX * (1 - fraction)), 0.0, 0.0)
        }

        // tilt left
        if fraction > 1 {
			self.transform = CATransform3DTranslate(self.transform,(centerX * (fraction  - 1)), 0.0, 0.0)
        }
	}
}

extension RadialGradientLayer {
	
	internal func resetSpotlight() {
		
		self.transform = CATransform3DIdentity
		self.opacity = 0.0
	}
}
