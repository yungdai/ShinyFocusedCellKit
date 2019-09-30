//
//  Enums.swift
//  ShinyFocusedCellKit
//
//  Created by Yung Dai on 2019-09-26.
//  Copyright © 2019 None. All rights reserved.
//

import Foundation

public enum Visibility: Int, Codable {
    case visible, hidden
}

public enum Direction {
    case left, right, top, bottom
}

public enum RotationDirection {
    case clockwise, counterClockwise
}

public enum ScrollDirection: String, Codable {
    case x, y, left, right, up, down
}

public enum Axis {
	case x, y, xy
}
