//
//  CompleteAttemptPresenter.swift
//  Summit
//
//  Created by Reagan Wood on 3/29/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit

public class CompleteAttemptPresenter {
    public init () { }
    public func present(with viewController: UIViewController, _ completion: @escaping () -> Void) {
        let completeTodayAction = UIAlertAction(title: "Complete today", style: .default) { (_) in
            completion()
        }
        
        viewController.presentActionSheet(withTitleOf: "Complete attempt", andMessageOf: nil, withActions: [completeTodayAction], addCancelAction: true)
    }
    
    
}
