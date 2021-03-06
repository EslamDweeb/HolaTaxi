//
//  CircleView.swift
//  HolaTaxi
//
//  Created by eslam dweeb on 4/16/18.
//  Copyright © 2018 eslam dweeb. All rights reserved.
//

import UIKit

class CircleView: UIView {

    @IBInspectable var borderColor: UIColor? {
        didSet{
            setupView()
        }
    }
    override func awakeFromNib() {
        setupView()
    }
    func setupView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderWidth = 1.5
        self.layer.borderColor = borderColor?.cgColor
    }
}


