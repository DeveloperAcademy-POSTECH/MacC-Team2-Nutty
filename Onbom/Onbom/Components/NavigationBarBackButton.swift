//
//  NavigationBarBackButton.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/10.
//

import SwiftUI

struct NavigationBarBackButton: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            // 백버튼이 묘하게 옆으로 치우쳐서 임시 처리. 좋은 방법 help 부탁해용
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
