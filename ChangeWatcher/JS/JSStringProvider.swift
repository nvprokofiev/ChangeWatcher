//
//  JSStringProvider.swift
//  UpdatesWatcher
//
//  Created by Nikolai Prokofev on 2020-10-23.
//

import Foundation

enum JSStringProvider {
    case removeAllHighlights
    
    private var title: String {
        switch self {
        case .removeAllHighlights:
            return "remove-all-highlights"
        }
    }
    
    private var type: String {
        switch self {
        default:
            return "js"
        }
    }
    
    var script: String? {
        return content
    }
    
    
    private var content: String? {
        if let filepath = Bundle.main.path(forResource: title, ofType: type) {
            do {
                let contents = try String(contentsOfFile: filepath)
                return contents
            } catch {
               assert(true, "Contents could not be loaded")
            }
        } else {
            assert(true, "File \(title).\(type) not found")
        }
        return nil
    }
}
