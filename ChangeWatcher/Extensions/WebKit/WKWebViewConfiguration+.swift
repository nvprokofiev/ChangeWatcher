//
//  WKWebViewConfiguration.swift
//  UpdatesWatcher
//
//  Created by Nikolai Prokofev on 2020-09-28.
///Users/nprokofev/Desktop/UpdatesWatcher/UpdatesWatcher/Extensions/WKWebViewConfiguration + Extensions.swift

import Foundation
import WebKit

extension WKWebViewConfiguration {
    
    func add(script: WKUserScript.CustomScripts?, scriptMessageHandler: WKScriptMessageHandler) {
        guard let name = script?.name, let script = script?.create() else {
            return }
        userContentController.addUserScript(script)
        userContentController.add(scriptMessageHandler, name: name)
    }
}
