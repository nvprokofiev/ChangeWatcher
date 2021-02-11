//
//  BrowserState.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-02-09.
//

import UIKit

enum BrowserState: Equatable {
    case initial
    case testing
    case running // when set to running - remove all highlights
    case pageNotRechable
    case longTapDetected(point: CGPoint)
}
