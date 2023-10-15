//
//  DigitalSignatureManager.swift
//  Onbom
//
//  Created by Sebin Kwon on 2023/10/04.
//

import SwiftUI

class DigitalSignatureManager: ObservableObject {
    @Published var paths: [[CGPoint]] = []
    @Published var currentPath: [CGPoint] = []
    let rectangle = Rectangle().path(in: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: 250))
    
    func gesture() -> some Gesture {
        DragGesture()
            .onChanged { value in
                if self.rectangle.contains(value.location) {
                    self.addNewCurrentPath(value)
                }
            }
            .onEnded { value in
                self.paths.append(self.currentPath)
                self.currentPath = []
            }
    }
    
    func addNewCurrentPath(_ value: DragGesture.Value) {
        currentPath.append(value.location)
    }
    
    func resetPaths() {
        self.paths = []
        self.currentPath = []
    }
}

//MARK: 전자서명 그리는 선
struct DrawLine: Shape {
    var currentPath: [CGPoint]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        guard let firstPoint = currentPath.first else { return path }
        
        path.move(to: firstPoint)
        for pathIndex in 1..<currentPath.count {
            path.addLine(to: currentPath[pathIndex])
        }
        return path
    }
}

