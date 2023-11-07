//
//  HomeViewModel.swift
//  Onbom
//
//  Created by moon on 11/7/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    enum HomeViewState {
        case ready
        case apply
    }
    
    @Published var state: HomeViewState = .ready
    
    public func onApplyLTCI() {
        state = .apply
    }
    
    public func onFlipCard() {
        if state == .apply {
            state = .ready
        }
        else if state == .ready {
            state = .apply
        }
    }

}

