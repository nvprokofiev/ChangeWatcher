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
        print(selectors)
        
        do {
            try selectors.forEach { selector in
                
                print(selector)
                let elements = try body.select(selector)
                
                guard elements.count <= 1 else {
                    return print(TestWatcherError.multipleValuesFound)
                }
                
                guard let element = elements.first() else {
                    return print(TestWatcherError.valueNotFound)
                }
                
                guard let testValue = try? element.text() else {
                    return print(TestWatcherError.unableToGetOuterHTML)
                }
                
                guard testValue == value else {
                    return print((TestWatcherError.mismatchedValue(value: value, newValue: testValue)))
                }
                
                succedSelectors.append(selector)
            }
            
            return completion(.success(succedSelectors))
            
        } catch (let error) {
            print("☹️ selector", error)
            return completion(.failure(.failedHTMLScrapig))
        }
    }
}
