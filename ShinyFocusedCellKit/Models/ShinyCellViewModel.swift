//
//  ViewModel.swift
//  ShinyFocusedCellKit
//
//  Created by Yung Dai on 2019-09-26.
//  Copyright © 2019 None. All rights reserved.
//

import UIKit

public struct ShinyCellViewModel {
	
	public var resetDuration: TimeInterval = 0.5
	public var divider: CGFloat = 10
	
	/// Axis you would prefer  the rotation to happen on
	public var axis: Axis = .x
	
	/// Rotation percentage of Pi
	public var rotation: CGFloat = 0.1
	
	public var startingAlpha: CGFloat = 1.0
	public init() {}
	
	mutating internal func set(resetDuration: TimeInterval?, divider: CGFloat?, axis: Axis?, rotation: CGFloat?, startingAlpha: CGFloat?) {
		
		if let resetDuration = resetDuration {
			self.resetDuration = resetDuration
		}
		
		if let divider = divider {
			self.divider = divider
		}
		
		if let axis = axis {
			self.axis = axis
		}
		
		if let rotation = rotation {
			self.rotation = rotation
		}
		
		if let startingAlpha = startingAlpha {
			self.startingAlpha = startingAlpha
		}
	}
}
