//
//  RadialGradientView.swift
//  ShinyFocusedCellKit
//
//  Created by Yung Dai on 2019-09-26.
//  Copyright © 2019 None. All rights reserved.
//

import UIKit

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
		return RadialGradientLayer(rect: rect, name: "spotlight")
	}
}
