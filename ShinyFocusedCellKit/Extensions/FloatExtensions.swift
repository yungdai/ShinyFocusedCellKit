//
//  FloatExtensions.swift
//  ShinyFocusedCellKit
//
//  Created by Yung Dai on 2019-09-26.
//  Copyright © 2019 None. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
 
    static public func getfractionFromScrollViewFor(_ length: CGFloat, scrollView: UIScrollView, onAxis: ScrollDirection, mulitiplier aMultiplier: CGFloat) -> CGFloat {
        
        
        let maxOffset = (onAxis == .x) ? length - scrollView.bounds.width: length - scrollView.bounds.height
        let multiplier = aMultiplier / maxOffset
        let fraction = (onAxis == .x) ? scrollView.contentOffset.x * multiplier : scrollView.contentOffset.y * multiplier
    
        return fraction
    }

    static public func returnNumberBetween(minimum smallerNumber: CGFloat, maximum largerNumber: CGFloat, inputValue value: CGFloat) -> CGFloat {

        let returnedFloat = CGFloat.minimum(largerNumber, CGFloat.maximum(smallerNumber, value))
        
        return returnedFloat
    }

    var degreesToRadians: CGFloat { return self * .pi / 180 }
    var radiansToDegrees: CGFloat { return self * 180 / .pi }
    
    /// helper to help you with circle/arc pie charts
    static public func convertPercentToRadiansForChart(percent: CGFloat, degreesAtZeroPercent: CGFloat) -> CGFloat {
        return CGFloat((3.6 * percent) + degreesAtZeroPercent).degreesToRadians
    }
}
