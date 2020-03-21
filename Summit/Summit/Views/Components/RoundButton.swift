//
//  RoundButton.swift
//  Summit
//
//  Created by Reagan Wood on 3/21/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit

class RoundButton: UIButton {
    init() {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundButton()
    }
    
    private func roundButton() {
        layer.cornerRadius = bounds.size.width / 2.0
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}
