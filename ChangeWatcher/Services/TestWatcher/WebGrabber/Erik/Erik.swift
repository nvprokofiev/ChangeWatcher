//
//  LayoutEngine.swift
//  Erik
/*
The MIT License (MIT)
Copyright (c) 2015-2016 Eric Marchand (phimage)
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

import Foundation
import WebKit

public typealias DocumentCompletionHandler = (Result<String, Error>) -> Void

// MARK: Error
public enum ErikError: Error {
    // Error provided by javascript
    case javaScriptError(message: String)
    // A timeout occurs
    case timeOutError(time: TimeInterval)
    // No content returned
    case noContent
    // HTML is not parsable
    case htmlNotParsable(html: String, error: Error)
    // Invalid url submited (NSURL init failed)
    case invalidURL(urlString: String)
}

// MARK: Erik class

open class Erik {
    
    open var layoutEngine: LayoutEngine
    open var encoding: String.Encoding = .utf8
    
    public var noContentPattern: String? = "<html><head></head><body></body></html>"
    
    public init(webView: WKWebView? = nil) {
        if let view = webView {
            self.layoutEngine = WebKitLayoutEngine(webView: view)
        } else {
            self.layoutEngine = WebKitLayoutEngine()
        }
    }

    open func visit(url: URL, completionHandler: DocumentCompletionHandler?) {
        layoutEngine.browse(url: url) {[unowned self] (object, error) -> Void in
            self.publish(content: object, error: error, completionHandler: completionHandler)
        }
    }

    open func currentContent(completionHandler: DocumentCompletionHandler?) {
        layoutEngine.currentContent {[unowned self] (object, error) -> Void in
            self.publish(content: object, error: error, completionHandler: completionHandler)
        }
    }

    fileprivate func publish(content: Any?, error: Error?, completionHandler: DocumentCompletionHandler?) {
        guard let html = content as? String else {
            completionHandler?(.failure(ErikError.noContent))
            return
        }
        
        if let pattern = noContentPattern , html.range(of: pattern, options: .regularExpression) != nil {
            completionHandler?(.failure(ErikError.noContent))
            return
        }

        guard error == nil else {
            completionHandler?(.failure(error!))
            return
        }
        
        completionHandler?(.success(html))
    }
}

extension Erik {

    public static let sharedInstance = Erik()
    
    public static func visit(url: Foundation.URL, completionHandler: DocumentCompletionHandler?) {
        Erik.sharedInstance.visit(url: url, completionHandler: completionHandler)
    }

    public static func currentContent(completionHandler: DocumentCompletionHandler?) {
        Erik.sharedInstance.currentContent(completionHandler: completionHandler)
    }
}
