//
//  ViewController.swift
//  Summit
//
//  Created by Reagan Wood on 3/14/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper
import SnapKit

class ViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "landingImage"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        createConstraints()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func createConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(view)
        }
    }
}

