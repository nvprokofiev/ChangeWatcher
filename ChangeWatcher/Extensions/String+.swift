//
//  String+.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-01-18.
//

import Foundation
import SwiftSoup

extension String {
    
    func percentEncoded() -> String? {
        self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    func isValidURL()-> Bool {
        let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector?.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            return match.range.length == self.utf16.count
        }
        return false
    }
    
    mutating func sanitized() -> String {
        self.removeAll { char -> Bool in
            return char == Character(Unicode.Scalar.BackslashN) || char == Character(Unicode.Scalar.BackslashT) || char == Character(Unicode.Scalar.BackslashR)
        }
        return self
    }
}
