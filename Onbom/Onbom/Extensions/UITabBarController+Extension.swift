//
//  UITabBarController+Extension.swift
//  Onbom
//
//  Created by moon on 10/7/23.
//

import UIKit

extension UITabBarController {
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tabBar.layer.masksToBounds = true
        self.tabBar.layer.cornerRadius = 24
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        self.tabBar.barTintColor = UIColor(.white)
        self.tabBar.backgroundColor = UIColor(.white)
        
    }
}
