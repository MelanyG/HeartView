//
//  CircleSegmentedView.swift
//  MediteoView
//
//  Created by Kirill Filippov on 8/3/18.
//  Copyright © 2018 Mediteo. All rights reserved.
//

import UIKit

public class CircleSegmentedView: UIView {

  private struct Constants {
    static let borderWidth: CGFloat = 8
    static let borderColor: UIColor = .clear
    static let fillColor: UIColor = .clear
    static let animationDuration: Double = 4.5
    static let maximumDegree: CGFloat = 360
    static let clockwise = true
  }

  private var radius: CGFloat {
    return bounds.width / 2 - Constants.borderWidth / 2
  }

  private var arcCenter: CGPoint {
    return CGPoint(x: bounds.width / 2, y: bounds.height / 2)
  }

  private var lastSegmentEndPoint: CGFloat = 0

  private var viewModel: CircleSegmentViewModel?

  override public func layoutSubviews() {
    super.layoutSubviews()
    cleanSubLayers()

    drawCircle(startAngle: CircleStartAngle.top.rawValue,
               endAngle: Constants.maximumDegree - abs(CircleStartAngle.top.rawValue),
               lineWidth: Constants.borderWidth,
               strokeColor: Constants.borderColor.cgColor,
               fillColor: Constants.fillColor.cgColor,
               animated: true)

    guard let viewModel = viewModel else { return }
    lastSegmentEndPoint = viewModel.startPoint.rawValue

    for segment in viewModel.segments {
      let endAngle = percentsToAngle(segment.percent) + lastSegmentEndPoint
      drawCircle(startAngle: lastSegmentEndPoint,
                 endAngle: endAngle,
                 lineWidth: segment.borderWidth,
                 strokeColor: segment.color.cgColor,
                 fillColor: UIColor.red.cgColor,
                 animated: true)
      lastSegmentEndPoint = endAngle
    }
  }

  public func bind(_ viewModel: CircleSegmentViewModel) {
    self.viewModel = viewModel
    layoutIfNeeded()
  }

  private func drawCircle(startAngle: CGFloat, endAngle: CGFloat, lineWidth: CGFloat,
                          strokeColor: CGColor, fillColor: CGColor, animated: Bool) {
    let circleBezierPath = UIBezierPath(arcCenter: arcCenter,
                                        radius: radius,
                                        startAngle: degreesToRadians(startAngle),
                                        endAngle: degreesToRadians(endAngle),
                                        clockwise: Constants.clockwise)

    let circleLayer = CAShapeLayer()
    circleLayer.path = circleBezierPath.cgPath
    circleLayer.lineWidth = lineWidth
    circleLayer.strokeColor = strokeColor
    circleLayer.fillColor = fillColor

    if animated == true {
      let animation = CABasicAnimation(keyPath: "strokeEnd")
      animation.fromValue = 0
      animation.toValue = 1
      animation.duration = Constants.animationDuration
      circleLayer.add(animation, forKey: nil)
    }

    layer.addSublayer(circleLayer)
  }

  private func cleanSubLayers() {
    layer.sublayers?.forEach({ layer in
      layer.removeFromSuperlayer()
    })
  }

  private func degreesToRadians(_ degrees: CGFloat) -> CGFloat {
    return CGFloat(degrees) * CGFloat.pi / 180
  }

  private func percentsToAngle(_ percents: CGFloat) -> CGFloat {
    return 360 * percents
  }
}
