//
//  ShinyFocusedCell.swift
//  ShinyFocusedCellKit
//
//  Created by Yung Dai on 2019-09-26.
//  Copyright © 2019 None. All rights reserved.
//

import UIKit


open class ShinyFocusedCell: UICollectionViewCell, ShinyFocusableCell {
	
	public var spotlight = RadialGradientView()

	public override func draw(_ rect: CGRect) {
		super.draw(rect)
		setupCell(rect: rect)
	}
}

