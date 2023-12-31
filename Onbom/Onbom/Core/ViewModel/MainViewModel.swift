//
//  HomeViewModel.swift
//  Onbom
//
//  Created by moon on 11/7/23.
//

import SwiftUI

class MainViewModel: ObservableObject {
    enum MainViewState {
        case begin, guide, before, after
    }
    
    @Published var state: MainViewState = .begin
    
    init() {}
    
    init(state: MainViewState) {
        self.state = state
    }
    
    public func onApplyLTCI() {
        state = .after
    }
    
    public func onFlipCard() {
        if(state == .guide) { return }
        
        if state == .after { state = .before }
        else if state == .before { state = .after }
    }

}

