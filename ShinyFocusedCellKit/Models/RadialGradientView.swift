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

public class RadialGradientView: UIView {

    public var innerColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.9008819018)
    public var outerColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)

    override public func draw(_ rect: CGRect) {
        super.draw(rect)

		let gradientLayer = RadialGradientLayer.makeSpotlightGradient(rect: rect)
		self.layer.addSublayer(gradientLayer)
	}
}
