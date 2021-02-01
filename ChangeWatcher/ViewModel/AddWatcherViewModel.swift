//
//  AddWatcherViewModel.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-01-27.
//

import UIKit

class AddWatcherViewModel: ObservableObject {

    private let item: TestableWatchItem
    private let container: UIView
    
    lazy var positioningPoint: CGPoint = {
        getPositioningPoint()
    }()
    
    init(_ item: TestableWatchItem, in container: UIView) {
        self.item = item
        self.container = container
    }
    
    private func convertTapPointIntoGlobvalCoordinates(from view: UIView) -> CGPoint {
        let globalTapPoint = view.convert(item.tapPoint.point, to: UIScreen.main.coordinateSpace)
        return globalTapPoint
    }
    
    private func getPositioningPoint() -> CGPoint {
        var point = convertTapPointIntoGlobvalCoordinates(from: container)
        point.y -= 70
        return point
    }
    
    func testWatchItem() {
        TestWatcherService.shared.test(item.watchItem) { result in
            
        }
    }
}
