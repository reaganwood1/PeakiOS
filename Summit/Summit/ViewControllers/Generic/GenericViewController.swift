//
//  GenericViewController.swift
//  Summit
//
//  Created by Reagan Wood on 3/14/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit

// SOURCE: https://will.townsend.io/2018/generic-viewcontrollers
open class GenericViewController<View: GenericView>: UIViewController {
    public var contentView: View {
        return view as! View
    }
    
    open override func loadView() {
        view = View()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        edgesForExtendedLayout = []
    }
}


open class GenericView: UIView {
    public required init() {
        super.init(frame: CGRect.zero)
        sharedInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }
    
    private func sharedInit() {
        initializeUI()
        backgroundColor = .summitBackground
        createConstraints()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        didLayoutView()
    }
    
    open func initializeUI() {}
    open func createConstraints() {}
    open func didLayoutView() {}
}
