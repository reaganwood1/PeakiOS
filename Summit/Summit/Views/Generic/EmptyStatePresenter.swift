//
//  EmptyStatePresenter.swift
//  Summit
//
//  Created by Reagan Wood on 4/9/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit

struct PresenterAttributes {
    var image: UIImage
    var title: String
    var buttonText: String? = nil
}
class EmptyStatePresenter {
    private var emptyState = EmptyStateView()
    
    func present(with attributes: PresenterAttributes, on view: GenericView, with delegate: EmptyStateViewDelegate? = nil) {
        emptyState.title = attributes.title
        emptyState.image = attributes.image
        
        if let buttonText = attributes.buttonText {
            emptyState.buttonText = buttonText
        }
        
        emptyState.delegate = delegate
        
        addEmptyState(to: view)
    }
    
    private func addEmptyState(to view: GenericView) {
        if emptyState.superview == nil {
            view.addSubview(emptyState)
            makeConstraints()
        }
    }
    
    public func removeEmptyState(from view: GenericView) {
        emptyState.removeFromSuperview()
    }
    
    private func makeConstraints() {
        emptyState.snp.remakeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}
