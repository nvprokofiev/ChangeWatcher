//
//  AddWatcherView.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-01-27.
//

import SwiftUI

struct AddWatcherView: View {
    
    @ObservedObject var viewModel: AddWatcherViewModel
    @Binding var state: BrowserState
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1)
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                            state = .running
                        }
                )
            
            HStack(spacing: 10) {
                
                Button(action: {
                    state = .running
                }, label: {
                   Image(systemName: "xmark")
                })
                
                Button(action: {
                    print("yes")
                }, label: {
                   Image(systemName: "checkmark")
                })
                
            }
            .shadow(radius: 10)
            .position(x: viewModel.positioningPoint.x, y: viewModel.positioningPoint.y)
        }
        .ignoresSafeArea()
        .buttonStyle(AppButtonStyle())

        
    }
}

//struct AddWatcherView_Previews: PreviewProvider {
//    static var previews: some View {
//        let watchingItem = WatchItem(urlString: "", value: "", selectors: [])
//        AddWatcherView(viewModel: AddWatcherViewModel(watchingItem))
//    }
//}


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
