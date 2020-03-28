//
//  UIViewController+Extensions.swift
//  Summit
//
//  Created by Reagan Wood on 3/28/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit

extension UIViewController {
    public func changeNavBack(to title: String) {
        let barButton = UIBarButtonItem()
        navigationController?.navigationBar.topItem?.backBarButtonItem = barButton
        self.title = title
    }
}
