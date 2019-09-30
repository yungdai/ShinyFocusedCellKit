//
//  ShinyFocusedCell.swift
//  ShinyFocusedCellKit
//
//  Created by Yung Dai on 2019-09-26.
//  Copyright © 2019 None. All rights reserved.
//

import UIKit

typealias FractionRotation = (fractionPoint: CGPoint, rotationTransform: CATransform3D)

open class ShinyFocusedCell: UICollectionViewCell {

	var spotlight = RadialGradientView()
	var shinyCellViewModel = ShinyCellViewModel()

	public override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		spotlight.removeFromSuperview()
	
		spotlight.bounds = rect
		spotlight.frame = rect
		addSubview(spotlight)
		bringSubviewToFront(spotlight)
	}
}

extension ShinyFocusedCell {
	internal func tilt(rotationTransform: CATransform3D) {
		layer.transform = rotationTransform
	}
}
