//
//  UIViewController+Extensions.swift
//  Summit
//
//  Created by Reagan Wood on 3/28/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit
import NotificationBanner

extension UIViewController {
    public func changeNavBack(to title: String) {
        let barButton = UIBarButtonItem()

        navigationController?.navigationBar.topItem?.backBarButtonItem = barButton
        self.title = title
    }
    
    public func hideNavBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    public func showNavBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    public func presentActionSheet(withTitleOf title: String?, andMessageOf message: String?, withActions actions: [UIAlertAction], addCancelAction: Bool = false) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions.forEach { alertController.addAction($0) }
        
        if addCancelAction {
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil) // TODO: constants
            alertController.addAction(cancelAction)
        }
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    internal func setRootVC(to vc: UIViewController) {
        guard let window = UIApplication.shared.delegate?.window, let rootWindow = window else {
            print("Root window could not be replaced")
            UIApplication.shared.keyWindow?.rootViewController = vc
            return
        }

        rootWindow.rootViewController = vc
    }
    
    public func alert(with title: String, messageText: String, buttonText: String, completion: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: messageText, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: .default, handler: completion))
        self.present(alertController, animated: true, completion: nil)
    }
    
    public func creatErrorBanner(with title: String) -> NotificationBanner {
        return createBanner(with: title, backgroundColor: .summitErrorRed, textColor: .textColor)
    }
    
    public func createBanner(with title: String, backgroundColor: UIColor = .textColor, textColor: UIColor = .summitSecondaryObjectBackground) -> NotificationBanner {
        NotificationBannerQueue.default.removeAll()
        
        
        let attributedTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0, weight: .medium), NSAttributedString.Key.foregroundColor : textColor])
        let banner = NotificationBanner(attributedTitle: attributedTitle)
        banner.backgroundColor = backgroundColor
        banner.duration = 1.0
        banner.animationDuration = 0.3
        
        return banner
    }
    
    public func handleGeneric(_ error: GenericServiceError) {
        switch error {
        case .noNetwork:
            creatErrorBanner(with: Strings.General.NoNetwork).show()
        case .serverError:
            creatErrorBanner(with: Strings.General.UnknownErrorTryAgain).show()
        }
    }
    
    public func handleAuth(_ error: AuthServiceError) {
        switch error {
        case .noNetworkConnection:
            creatErrorBanner(with: Strings.General.NoNetwork).show()
        case .serverError:
            creatErrorBanner(with: Strings.General.UnknownErrorTryAgain).show()
        case .serverErrorWithMessage(let errorMessage):
            creatErrorBanner(with: errorMessage).show()
        }
    }
}
