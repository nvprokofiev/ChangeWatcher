//
//  BrowserToolbarView.swift
//  UpdatesWatcher
//
//  Created by Nikolai Prokofev on 2020-09-20.
//

import SwiftUI

typealias ToolbarButtonHandler = (enabled: Bool, action: ()->())

struct BrowserToolbarView: View {
    
    var backButton: ToolbarButtonHandler
    var forwardButton: ToolbarButtonHandler
    
    var body: some View {
        
        VStack(spacing: 0) {
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(.secondary)
                .padding(.bottom, 16)
            HStack {
                ToolbarButtonView(systemImage: "arrow.left", handler: backButton)
                    .padding(.leading, 30)
                ToolbarButtonView(systemImage: "arrow.right", handler: forwardButton)
                    .padding(.leading, 30)
                Spacer()
            }
            Spacer()
        }
        .frame(height: 44)
        .padding(.bottom, 20)
        
    }
}
