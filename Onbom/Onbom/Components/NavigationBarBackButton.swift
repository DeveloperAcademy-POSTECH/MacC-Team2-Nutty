//
//  NavigationBarBackButton.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/10.
//

import SwiftUI

struct NavigationBarBackButton: View {
    @EnvironmentObject var navigation: NavigationManager
    
    var body: some View {
        Button {
            navigation.pop()
            navigation.isUserFromSubmitCheckListView = false
        } label: {
            HStack() {
                Text("")
                Image("chevronLeft")
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}

extension View {
    func navigationBarBackButton() -> some View {
        self
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationBarBackButton()
                }
            }
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
