//
//  ScreenCoordinates.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-01-28.
//

import UIKit

struct WebViewTapPoint: Decodable {

    let x: Int
    let y: Int
    
    var point: CGPoint {
        return CGPoint(x: x, y: y)
    }
    
    enum CodingKeys: String, CodingKey {
        case x = "clientX"
        case y = "clientY"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        x = try container.decode(Int.self, forKey: .x)
        y = try container.decode(Int.self, forKey: .y)
    }
}
