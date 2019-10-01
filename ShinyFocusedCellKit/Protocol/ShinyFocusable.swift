//
//  ShinyFocusable.swift
//  ShinyFocusedCellKit
//
//  Created by Yung Dai on 2019-09-30.
//  Copyright © 2019 None. All rights reserved.
//

import UIKit

public protocol ShinyFocusable: UICollectionViewCell {
	
	var spotlight: RadialGradientView { get set }
}

public extension ShinyFocusable {
	
	/// Used inside the draw(_ rect:) delegate function
	func setupCell(rect: CGRect) {
		
		spotlight.removeFromSuperview()
		spotlight.bounds = rect
		spotlight.frame = rect
		addSubview(spotlight)
		bringSubviewToFront(spotlight)
		layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
		self.clipsToBounds = true
	}
	
	/// tilt the cell with a CATransform3d Rotation
	func tilt(rotationTransform: CATransform3D) {
		layer.transform = rotationTransform
	}
}
