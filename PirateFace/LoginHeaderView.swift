//
//  LoginHeaderView.swift
//  PirateFace
//
//  Created by movil6 on 07/11/16.
//  Copyright © 2016 movil6. All rights reserved.
//

import UIKit

class LoginHeaderView: UIView {
    
    override func awakeFromNib() {
        layer.shadowColor = SHADOW_COLOR.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 1.0
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
