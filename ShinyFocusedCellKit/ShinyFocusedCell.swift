//
//  ShinyFocusedCell.swift
//  ShinyFocusedCellKit
//
//  Created by Yung Dai on 2019-09-26.
//  Copyright © 2019 None. All rights reserved.
//

import UIKit


open class ShinyFocusedCell: UICollectionViewCell, ShinyFocusable {
	
	public var spotlight = RadialGradientView()

	public override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		spotlight.removeFromSuperview()
		spotlight.bounds = rect
		spotlight.frame = rect
		addSubview(spotlight)
		bringSubviewToFront(spotlight)
		self.clipsToBounds = true
	}
}

