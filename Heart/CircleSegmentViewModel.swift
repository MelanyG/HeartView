//
//  CircleSegmentViewModel.swift
//
//  Created by Kirill Filippov on 8/3/18.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

public struct CircleSegmentViewModel {
  public let segments: [CircleSegment]
  public let borderWidth: CGFloat
  public let borderColor: UIColor
  public let fillColor: UIColor
  public let startPoint: CircleStartAngle
}

public struct CircleSegment {
  public let color: UIColor
  public let percent: CGFloat
  public let borderWidth: CGFloat
}

public enum CircleStartAngle: CGFloat {
  case top = -90
  case bottom = 90
  case left = 180
  case right = 0
}
