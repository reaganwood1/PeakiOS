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
    
    public func hideNavBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    public func showNavBar() {
        navigationController?.navigationBar.isHidden = false
    }
    
    public func presentActionSheet(withTitleOf title: String?, andMessageOf message: String?, withActions actions: [UIAlertAction], addCancelAction: Bool = false) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions.forEach { alertController.addAction($0) }
        
        if addCancelAction {
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil) // TODO: constants
            alertController.addAction(cancelAction)
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
}
