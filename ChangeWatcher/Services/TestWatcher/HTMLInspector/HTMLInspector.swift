//
//  HTMLInspector.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-02-02.
//

import Foundation

typealias HTML = String

protocol HTMLInspector {
    
    func inspect(_ html: HTML, for selectors: [CSSSelector], matching value: String, _ completion: @escaping (Result<[CSSSelector], Error>)-> Void)
}
