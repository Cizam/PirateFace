//
//  LoginButton.swift
//  PirateFace
//
//  Created by movil6 on 07/11/16.
//  Copyright © 2016 movil6. All rights reserved.
//

import UIKit

class LoginButton: UIButton {
    
    override func awakeFromNib() {
        layer.backgroundColor = UIColor(red: 213/255.0, green: 78/255.0, blue: 55/255.0, alpha: 1).cgColor
        layer.cornerRadius = 5
        layer.shadowColor = SHADOW_COLOR.cgColor
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowRadius = 5
        tintColor = UIColor.white
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
