//
//  RadialGradientView.swift
//  ShinyFocusedCellKit
//
//  Created by Yung Dai on 2019-09-26.
//  Copyright © 2019 None. All rights reserved.
//

import UIKit

let dimLayerBackgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.15)
let spotlightString = "spotlight"
let dimLayerString = "dimLayer"

public class ShinyFocusLayer: CALayer {
	
	var dimLayer = CALayer()
	var spotlightLayer = RadialGradientLayer()
	
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
	
	convenience public init(rect: CGRect) {
		self.init()
		
		dimLayer.backgroundColor = dimLayerBackgroundColor.cgColor
		dimLayer.bounds = rect
		dimLayer.setLayerToCenter(of: rect)
		dimLayer.opacity = 0
		dimLayer.name = dimLayerString
		spotlightLayer = RadialGradientLayer(rect: rect, name: spotlightString)
		
		addSublayer(dimLayer)
		addSublayer(spotlightLayer)
	}
	
	public func setSpotlight(innerColor: UIColor?, outerColor: UIColor? ) {

		guard let spotlight = sublayers?.first(where: { $0.name == spotlightString }) as? RadialGradientLayer else { fatalError("No Spotlight Layer") }
		
		spotlight.set(innerColor: innerColor, outerColor: outerColor)
	}
}


public class RadialGradientView: UIView {

    public var innerColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.9008819018)
    public var outerColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)

    override public func draw(_ rect: CGRect) {
        super.draw(rect)

		let gradientLayer = RadialGradientLayer.makeSpotlightGradient(rect: rect)
		self.layer.addSublayer(gradientLayer)
	}
}

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
		ctx.saveGState()

		let colors = [innerColor.cgColor, outerColor.cgColor] as CFArray
		let endRadius = min(bounds.width, bounds.height) / 2
		let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
		let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil)
		ctx.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: endRadius, options: .drawsBeforeStartLocation)
	}
	
	public func set(innerColor: UIColor?, outerColor: UIColor?)  {
		
		if let innerColor = innerColor {
			self.innerColor = innerColor
		}
		
		if let outerColor = outerColor {
			self.outerColor = outerColor
		}
	}
	
	static func makeSpotlightGradient(rect: CGRect) -> CAGradientLayer {

		let spotlight = RadialGradientLayer(rect: rect, name: spotlightString)

		spotlight.backgroundColor = UIColor.clear.cgColor
		spotlight.opacity = 0
		return spotlight
	}
}
