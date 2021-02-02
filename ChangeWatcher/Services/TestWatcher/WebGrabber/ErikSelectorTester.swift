//
//  ErikSelectorTester.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-02-01.
//

import Foundation
import SwiftSoup
class ErikSelectorTester: SelectorTester {
    
    func test(selectors: [CSSSelector], from url: URL, matching value: String, completion: @escaping (Result<[CSSSelector], Error>) -> Void) {
        
        
        Erik.visit(url: url) { result in
            
            switch result {
            case .failure(let error):
                return completion(.failure(error))
            case .success(let html):
                
                guard let body = try? SwiftSoup.parse(html).body() else {
                    return completion(.failure(TestWatcherError.failedHTMLParsing))
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
                    return completion(.failure(TestWatcherError.failedHTMLScrapig))
                }
            }
        }
    }
}
