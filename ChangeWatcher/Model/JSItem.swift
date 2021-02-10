//
//  TestableWatchItem.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-01-28.
//

import UIKit

struct JSItem: Decodable {
    
    var urlString: String
    var value: String
    var selectors: [String]
    let tapPoint: WebViewTapPoint
}
