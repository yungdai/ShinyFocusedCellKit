//
//  CALayerExtensions.swift
//  ShinyFocusedCellKit
//
//  Created by Yung Dai on 2019-09-26.
//  Copyright © 2019 None. All rights reserved.
//
import UIKit

extension CALayer {

	public func drawCircleInShape(shapeLayer: CAShapeLayer, centerPoint: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockWise: Bool, strokeColor: UIColor, fillColor: UIColor, lineWidth: CGFloat, inRect rect: CGRect) {
		
		shapeLayer.bounds = rect
		shapeLayer.setLayerToCenter(of: rect)
		
		shapeLayer.strokeColor = strokeColor.cgColor
		shapeLayer.fillColor = fillColor.cgColor
		shapeLayer.lineWidth = lineWidth
		shapeLayer.lineCap = .round
		
		let circlePath = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockWise)
		
		// assign the path the the circleArc
		shapeLayer.path = circlePath.cgPath
		
	}
	
	
	/// use this function to rotate a layer on the Y axis to flip the view in that direction.
	public func transformForFractionOnYAxis(_ fraction:CGFloat, fromView view: UIView) -> CATransform3D {
		
		var identify = CATransform3DIdentity
		identify.m34 = -1.0 / 1000.0
		let angle = Double(1.0 - fraction) * -Double.pi / 2
		
		let xOffSet = view.bounds.width * 0.5
		let rotateTransform = CATransform3DRotate(identify, CGFloat(angle), 0.0, 1.0, 0.0)
		
		let translateTransform = CATransform3DMakeTranslation(xOffSet, 0.0, 0.0)
		return CATransform3DConcat(rotateTransform, translateTransform)
	}
	
	/// Create and Arc and draw onto a layer
	public func createArcInCurrentLayer(_ rect: CGRect, withRadius circleRadius: CGFloat, lineCap: CAShapeLayerLineCap, lineWidth: CGFloat, startArc: CGFloat, endArc: CGFloat, withColour colour: UIColor) {
		
		let circleShapeLayer = CAShapeLayer()
		circleShapeLayer.strokeColor = colour.cgColor
		circleShapeLayer.strokeStart = startArc
		circleShapeLayer.strokeEnd = endArc
		circleShapeLayer.fillColor = UIColor.clear.cgColor
		circleShapeLayer.lineWidth = lineWidth
		circleShapeLayer.bounds = rect
		circleShapeLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
		
		// make sure that you adjust for the anchor point on the
		circleShapeLayer.position = CGPoint(x: rect.width / 2 , y: rect.height / 2)
		circleShapeLayer.lineJoin = CAShapeLayerLineJoin.miter
		circleShapeLayer.lineCap = lineCap
		
		circleShapeLayer.path = UIBezierPath(ovalIn: CGRect(x: frame.size.width / 2 - circleRadius, y: frame.size.height / 2 - circleRadius, width: 2 * circleRadius, height: 2 * circleRadius)).cgPath
		
		addSublayer(circleShapeLayer)
	}
	
	
	/// Use this to set the CALayer to the center a parent view.
	public func setLayerToCenter(of rect: CGRect) {
		
		position = CGPoint(x: rect.width / 2, y: rect.height / 2)
	}
	
	public class func fullyRotateLayer(targetLayer: CALayer, duration: Double = 1.0, direction: RotationDirection, repeatCount: Float, timingFunction: CAMediaTimingFunction) {
		
		let fromValue = 0.0
		let toValue = (direction == .clockwise) ? Double.pi * 2 : -Double.pi * 2
		
		if targetLayer.animation(forKey: "transform.rotation") == nil {
			
			let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
			
			rotationAnimation.fromValue = fromValue
			rotationAnimation.toValue = toValue
			rotationAnimation.duration = duration
			rotationAnimation.repeatCount = repeatCount
			rotationAnimation.fillMode = .forwards
			rotationAnimation.timingFunction = timingFunction
			rotationAnimation.isRemovedOnCompletion = false
			targetLayer.add(rotationAnimation, forKey: nil)
		}
	}
}
