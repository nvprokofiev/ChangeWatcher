//
//  AddWatcherView.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-01-27.
//

import SwiftUI

struct AddWatcherView: View {
    
    @ObservedObject var viewModel: AddWatcherViewModel
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1)
            
            HStack() {
                
                Button(action: {

                }, label: {
                   Image(systemName: "xmark")
                })
                
                Button(action: {
                    print("yes")
                }, label: {
                   Image(systemName: "checkmark")
                })
            }
            .cornerRadius(20)
            .shadow(radius: 10)
            .padding(.horizontal, 30)
        }
        .ignoresSafeArea()
    }
}

struct AddWatcherView_Previews: PreviewProvider {
    static var previews: some View {
        let watchingItem = WatchItem(urlString: "", value: "", selectors: [])
        AddWatcherView(viewModel: AddWatcherViewModel(watchingItem))
    }
}
