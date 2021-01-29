//
//  TestWatcherError.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-01-27.
//

import Foundation

enum WatcherError: Error, CustomStringConvertible {
    case invalidURLString
    case failedHTMLGrabbing
    case failedHTMLParsing
    case failedHTMLScrapig
    case valueNotFound
    case multipleValuesFound
    case unableToGetOuterHTML
    case mismatchedValue(value: String, newValue: String)
    
    var description: String {
        switch self {
        case .mismatchedValue(let value, let newValue):
            return "Mismatched value: \(value) -/- \(newValue)"
        default:
            return String(describing: self)
        }
    }
}
