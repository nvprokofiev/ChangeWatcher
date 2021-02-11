//
//  TestWatcherError.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-02-01.
//

import Foundation

enum TestWatcherError: Error {
    
    case invalidURLString
    case failedHTMLGrabbing
    case failedHTMLParsing
    case failedHTMLScrapig
    case valueNotFound
    case multipleValuesFound
    case unableToGetOuterHTML
    case testFailed
    case mismatchedValue(value: String, newValue: String)
    case other(Error)
    
    var description: String {
        switch self {
        case .mismatchedValue(let value, let newValue):
            return "Mismatched value: \(value) -/- \(newValue)"
        case .other(let error):
            return "Error: \(error.localizedDescription)"
        default:
            return String(describing: self)
        }
    }
}
