//
//  ShinyFocusedCollectionView.swift
//  ShinyFocusableKit
//
//  Created by Yung Dai on 2019-09-26.
//  Copyright © 2019 None. All rights reserved.
//

import UIKit

typealias FractionRotation = (fractionPoint: CGPoint, rotationTransform: CATransform3D)

public protocol ShinyFocusedCollectionView: UICollectionViewController {
	
	var position: CGFloat { get set }
	var shinyCellViewModel: ShinyCellViewModel { get set }
}

extension ShinyFocusedCollectionView {
	
	/// Required: Use this function inside scrollViewDidScroll(_ scrollView:) in your collectionViewController
	public func animateSpotlightOnScroll() {
		
		let gesture = collectionView.panGestureRecognizer
		let translation = gesture.translation(in: collectionView)
		position = translation.x
		
		let axis = shinyCellViewModel.axis
		
		switch gesture.state {
		case .changed:
			
			switch axis {
				
			case .x:
				tiltSpotlightOnXAxisOfCells(at: shinyCellViewModel.divider)
				
			case .xy:
				tiltSpotlightOnXYAxisOfCells(with: translation, at: shinyCellViewModel.divider)
				
			default:
				tiltSpotlightOnXYAxisOfCells(with: translation, at: shinyCellViewModel.divider)
			}

		default:
			resetSpotlightCells()
		}
	}
	
	
	public func setResetDuration(with duration: TimeInterval) {
		shinyCellViewModel.resetDuration = duration
	}
	

	public func resetSpotlightCells() {
		
		let viewModel = shinyCellViewModel
		
		self.collectionView.visibleCells.forEach {
			guard let cell = $0 as? ShinyFocusable else { return }

			UIView.animate(withDuration: viewModel.resetDuration, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {

				cell.spotlight.resetSpotlight()
				cell.layer.transform = CATransform3DIdentity
			})
		}
	}
	
	// MARK: Cell Tilting
	public func tiltCellsOnXYAxis(with translation: CGPoint, at divider: CGFloat) {
		
		let args = makeTiltingOnXYAxis(from: translation, divider: divider)
		
		self.collectionView.visibleCells.forEach {
			guard let cell = $0 as? ShinyFocusable else { return }

			
			cell.tilt(rotationTransform: args.rotationTransform)
		}
	}

	public func tiltCellsOnXAxis(at divider: CGFloat) {
		
		let args = makeTiltingOnXAxis(at: divider)
		let rotationTransform = args.rotationTransform
		
		collectionView.visibleCells.forEach {
			guard let cell = $0 as? ShinyFocusable else { return }
			cell.tilt(rotationTransform: rotationTransform)
		}
	}
	
	// MARK: Spotlight Tilting

	/// Animate the spottlight while tiltings all cells
	func tiltSpotlightOnXAxisOfCells(at divider: CGFloat) {
		
		let args = makeTiltingOnXAxis(at: divider)
		let fraction = args.fractionPoint.x
		let rotationTransform = args.rotationTransform
		
		self.collectionView.visibleCells.forEach {
			guard let cell = $0 as? ShinyFocusable else { return }

			cell.spotlight.animateSpotlightOnXAxis(fraction: fraction)
			cell.tilt(rotationTransform: rotationTransform)
		}
	}
	
	func tiltSpotlightOnXYAxisOfCells(with translation: CGPoint, at divider: CGFloat) {
		
		let args = makeTiltingOnXAxis(at: divider)
		let fractionPoint = args.fractionPoint
		let rotationTransform = args.rotationTransform
		
		self.collectionView.visibleCells.forEach {
			guard let cell = $0 as? ShinyFocusable else { return }

			cell.spotlight.animateSpotlightOnXYAxis(fractionPoint: fractionPoint)
			cell.tilt(rotationTransform: rotationTransform)
		}
	}
	
	private func makeTiltingOnXAxis(at divider: CGFloat) -> FractionRotation {
		
		// I want the positioning to set in relation to the cell width to the the possible width of the collectionView
		
		// this creates less travel distance to maximise the rotation
		
		// use the divider to calculate how much less space than the collectionView size do you want to move the cell to affect it.
		
		let multiplier = 1.0 / (self.collectionView.bounds.width / divider)
		let offset = position * multiplier
		
		// make sure that returned faction is number between 0 and 2
		let xFraction = CGFloat.returnNumberBetween(minimum: 0.5 , maximum: 1.5, inputValue: 1.0 - offset)
		
		let fraction = CGPoint(x: xFraction, y: 0)
		
		// transformation code
		var identity = CATransform3DIdentity
		
		// perpective calculation using the m34 matrix
		identity.m34 = -1.0 / 1000.0
		
		// get the angle, it will be rotation % of pi
		let angle = (1.0 - fraction.x) * (CGFloat.pi * shinyCellViewModel.rotation)
		
		// rotation along the Y Axis.  The cell layer archorPoint is already CGPoint(x: 0.5, y:0.5)
		let rotationTransform = CATransform3DRotate(identity, angle, 0, 1.0, 0)
		
		return FractionRotation(fractionPoint: fraction, rotationTransform: rotationTransform)
	}
	
	private func makeTiltingOnXYAxis(from translation: CGPoint, divider: CGFloat) -> FractionRotation {
		
		// I want the positioning to set in relation to the cell width to the the possible width of the collectionView
		// this creates less travel distance to maximise the rotation
		
		
		// use the divider to calculate how much less space than the collectionView size do you want to move the cell to affect it.
		let multiplierX = 1.0 / (self.collectionView.bounds.width / divider)
		let multiplierY = 1.0 / (self.collectionView.bounds.height / divider)
		
		let offsetX = translation.x * multiplierX
		let offsetY = translation.y * multiplierY
		
		// make sure that returned faction is number between 0 and 2
		let fractionX = CGFloat.returnNumberBetween(minimum: 0 , maximum: 2, inputValue: 1.0 - offsetX)
		let fractionY = CGFloat.returnNumberBetween(minimum: 0, maximum: 2, inputValue: 1.0 + offsetY)
		
		let fraction = CGPoint(x: fractionX, y: fractionY)
		
		// transformation code
		var identity = CATransform3DIdentity
		
		// perpective calculation using the m34 matrix
		identity.m34 = -1.0 / 1000.0
		
		// get the angle, it will be 10% of pi
		let angleX = (1.0 - fractionX) * (CGFloat.pi * shinyCellViewModel.rotation)
		let angleY = (1.0 - fractionY) * (CGFloat.pi * shinyCellViewModel.rotation)
		
		// rotation along the Y Axis.  The cell layer archorPoint is already CGPoint(x: 0.5, y:0.5)
		let rotationX = CATransform3DRotate(identity, angleX, 0, 1.0, 0)
		let rotationY = CATransform3DRotate(identity, angleY, 1.0, 0, 0)
		
		// concactinate the two rotations together
		let rotationXY = CATransform3DConcat(rotationX, rotationY)
		
		return FractionRotation(fractionPoint: fraction, rotationTransform: rotationXY)
	}

	public func configureShinyCellModel(resetDuration: TimeInterval?, divider: CGFloat?, axis: Axis?, rotation: CGFloat?, startingAlpha: CGFloat?) {
		
		shinyCellViewModel.set(resetDuration: resetDuration, divider: divider, axis: axis, rotation: rotation, startingAlpha: startingAlpha)
	}
}


