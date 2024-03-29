//
//  RadialGradientLayer.swift
//  ShinyFocusedCellKit
//
//  Created by Yung Dai on 2019-09-27.
//  Copyright © 2019 None. All rights reserved.
//

import UIKit

let defaultInnerColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2559315263)
let defaultOuterColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)

public class RadialGradientLayer: CAGradientLayer {
	
	public var innerColor: UIColor = defaultInnerColor
	public var outerColor: UIColor = defaultOuterColor
	
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
	
    /// Creates a
	static func makeSpotlightGradient(rect: CGRect) -> RadialGradientLayer {
		let spotlight = RadialGradientLayer(rect: rect, name: spotlightString)
		return spotlight
	}
}
