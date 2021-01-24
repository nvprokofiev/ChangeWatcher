//
//  WKUserScript + Extensions.swift
//  UpdatesWatcher
//
//  Created by Nikolai Prokofev on 2020-09-28.
//

import Foundation
import WebKit

extension WKUserScript {
    
    enum CustomScripts: String, CaseIterable {
        case longPressEvent
        case highlightSelectedElement
        case removeAllHighlights
//        case finder
//        case cssSelectorGenerator
        case disableTextSelection
    
        var name: String { return rawValue }
        
        var fileName: String {
            switch self {
            case .longPressEvent:
                return "long-press-event"
//            case .cssSelectorGenerator:
//                return "css-selector-generator"
            case .disableTextSelection:
                return "disable-text-selection"
            case .highlightSelectedElement:
                return "highlight-selected-element"
            case .removeAllHighlights:
                return "remove-all-highlights"
//            case .finder:
//                return "finder"
            }
        }
        
        private var source: String? {
            return extractScriptFromFile(fileName)
        }
        
        func create() -> WKUserScript? {
            guard let source = source else { return nil }
            return WKUserScript(source: source, injectionTime: injectionTime, forMainFrameOnly: forMainFrameOnly)
        }
        
        private func extractScriptFromFile(_ file: String) -> String? {
            guard let filePath = Bundle.main.path(forResource: file, ofType: "js") else {
                print("Unable to find file with name \(file)")
                return nil
            }
            do {
                return try String(contentsOfFile: filePath)
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }
        
        private var injectionTime: WKUserScriptInjectionTime {
            switch self {
//            case .cssSelectorGenerator:
//                return .atDocumentStart
            default:
                return .atDocumentEnd
            }
        }
        
        private var forMainFrameOnly: Bool {
            return false
        }
    }
}
