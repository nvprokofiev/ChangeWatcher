//
//  ToolbarButtonView.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-01-18.
//

import SwiftUI

struct ToolbarButtonView: View {

    var image: Image
    var handler: ToolbarButtonHandler
    
    init(image: Image, handler: ToolbarButtonHandler) {
        self.image = image
        self.handler = handler
    }
    
    init(systemImage: String, handler: ToolbarButtonHandler) {
        self.image = Image(systemName: systemImage)
        self.handler = handler
    }
    
    var body: some View {
        Button(action: {
            handler.action()
        }, label: {
            image
        })
        .disabled(!handler.enabled)
        .foregroundColor(handler.enabled ? .black : .gray)
        .font(.body)
    }
}
