//
//  StringContentSelectorTester.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-02-01.
//

import Foundation
import SwiftSoup

class StringContentSelectorTester: SelectorTester {

    func test(selectors: [CSSSelector], from url: URL, matching value: String, completion: @escaping (Result<[CSSSelector], TestWatcherError>)->Void ) {
        
        guard let html = try? String(contentsOf: url) else {
            return completion(.failure(.failedHTMLGrabbing))
        }
        guard let body = try? SwiftSoup.parse(html).body() else {
            return completion(.failure(.failedHTMLParsing))
        }
        
        var succedSelectors = [CSSSelector]()
        
        do {
            try selectors.forEach { selector in
                
                let elements = try body.select(selector)
                
                guard elements.count <= 1 else {
                    return print(selector, TestWatcherError.multipleValuesFound)
                }
                
                guard let element = elements.first() else {
                    return print(selector, TestWatcherError.valueNotFound)
                }
                
                guard let testValue = try? element.text() else {
                    return print(selector, TestWatcherError.unableToGetOuterHTML)
                }
                
                guard testValue.lowercased() == value.lowercased() else {
                    return print(selector, TestWatcherError.mismatchedValue(value: value, newValue: testValue))
                }
                
                succedSelectors.append(selector)
            }
            
            completion(.success(succedSelectors))
            
        } catch (let error) {
            print("☹️ selector", error)
            return completion(.failure(.failedHTMLScrapig))
        }
    }
}
