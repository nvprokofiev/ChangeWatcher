//
//  Watchable.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-01-18.
//

import Foundation

protocol Watchable {
    
    var urlString: String { get }
    var value: String { get }
    var selectors: [String] { get }
    var testMethod: TestMethod { get }
}
