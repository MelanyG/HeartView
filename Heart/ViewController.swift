//
//  ViewController.swift
//  Heart
//
//  Created by Melaniia Hulianovych on 12/20/18.
//  Copyright © 2018 Melaniia Hulianovych. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var heartView: CircleSegmentedView!
  override func viewDidLoad() {
    super.viewDidLoad()
    let circleSegment = CircleSegment(color: UIColor.blue, percent: 0.75, borderWidth: 8)
    let viewModel = CircleSegmentViewModel(segments: [circleSegment],
                                           borderWidth: 8,
                                           borderColor: UIColor.red,
                                           fillColor: UIColor.green,
                                           startPoint: CircleStartAngle.top)
    heartView.bind(viewModel)
  }


}

