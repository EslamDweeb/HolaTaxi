//
//  RoundShadowView.swift
//  HolaTaxi
//
//  Created by eslam dweeb on 4/16/18.
//  Copyright © 2018 eslam dweeb. All rights reserved.
//

import UIKit

class RoundShadowView: UIView {
    
    override func awakeFromNib() {
        setupView()
    }
    func setupView(){
        self.layer.cornerRadius = 5.0
        self.layer.shadowRadius = 5.0
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}
