//
//  RoundIageView.swift
//  HolaTaxi
//
//  Created by eslam dweeb on 4/16/18.
//  Copyright © 2018 eslam dweeb. All rights reserved.
//

import UIKit

class RoundIageView: UIImageView {
 
    override func awakeFromNib() {
        setupView()
    }

    func setupView(){
        self.layer.cornerRadius = frame.width / 2
        self.clipsToBounds = true
    }

}
