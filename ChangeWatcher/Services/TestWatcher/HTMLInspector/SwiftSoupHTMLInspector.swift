//
//  SwiftSoupHTMLInspector.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-02-02.
//

import Foundation
import SwiftSoup

class SwiftSoupHTMLInspector: HTMLInspector {
    
    static let shared: SwiftSoupHTMLInspector = SwiftSoupHTMLInspector()
    
    private init() {}
    
    func inspect(_ html: HTML, for selectors: [CSSSelector], matching value: String, _ completion: @escaping (Result<[CSSSelector], TestWatcherError>)-> Void) {

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
