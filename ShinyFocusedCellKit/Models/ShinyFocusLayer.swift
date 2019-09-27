//
//  ShinyFocusLayer.swift
//  ShinyFocusedCellKit
//
//  Created by Yung Dai on 2019-09-27.
//  Copyright © 2019 None. All rights reserved.
//

import UIKit

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
