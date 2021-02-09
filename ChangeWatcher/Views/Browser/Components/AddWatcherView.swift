//
//  AddWatcherView.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-01-27.
//

import SwiftUI

struct AddWatcherView: View {

    private var viewModel: BrowserViewModel
    private var positionPoint: CGPoint
    
    init(viewModel: BrowserViewModel, at point: CGPoint) {
        self.viewModel = viewModel
        self.positionPoint = point
    }
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1)
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                            viewModel.state = .running
                        }
                )
            
            HStack(spacing: 10) {
                
                Button(action: {
                    viewModel.cancel()
                }, label: {
                   Image(systemName: "xmark")
                })
                Button(action: {
                    viewModel.add()
                }, label: {
                   Image(systemName: "checkmark")
                })
            }
            .shadow(radius: 10)
            .position(x: positionPoint.x, y: positionPoint.y)
        }
        .ignoresSafeArea()
        .buttonStyle(AppButtonStyle())
    }
}

struct AppButtonStyle: ButtonStyle {
        
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration
            .label
            .font(Font.system(size: 20, weight: .bold, design: .rounded))
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .padding(.horizontal, 10)
            .foregroundColor(.white)
            .offset(y: -1)
            .frame(height: 30)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .opacity(configuration.isPressed ? 0.6 : 1)
            .animation(.spring())
    }
}
