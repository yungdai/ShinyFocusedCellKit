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
	public var divider: CGFloat = 2
	
	/// Axis you would prefer  the rotation to happen on
	public var axis: Axis = .x
	
	/// Rotation percentage of Pi
	public var rotation: CGFloat = 0.1
	public init() {}
}
