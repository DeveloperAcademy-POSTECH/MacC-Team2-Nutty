//
//  HomeViewModel.swift
//  Onbom
//
//  Created by moon on 11/7/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    enum HomeViewState {
        case guide
        case before
        case after
    }
    
    @Published var state: HomeViewState = .before
    
    public func onApplyLTCI() {
        state = .after
    }
    
    public func onFlipCard() {
        if state == .after {
            state = .before
        }
        else if state == .before {
            state = .after
        }
    }

}

