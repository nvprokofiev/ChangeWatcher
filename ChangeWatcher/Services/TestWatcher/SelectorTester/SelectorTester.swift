//
//  SelectorTester.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-02-01.
//

import Foundation

typealias CSSSelector = String

protocol SelectorTester {
    
    var parameters: SelectorTesterParameters { get }
    
    func test(_ completion: @escaping (Result<[CSSSelector], Error>)-> Void)
}
