//
//  SplashScreenView.swift
//  Summit
//
//  Created by Reagan Wood on 3/14/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

public class SplashScreenView: GenericView {
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "landingImage"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    public override func initializeUI() {
        super.initializeUI()
        addSubview(imageView)
    }
    
    public override func createConstraints() {
        super.createConstraints()
        imageView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}
