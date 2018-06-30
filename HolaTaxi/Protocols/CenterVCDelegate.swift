//
//  CenterVCDelegate.swift
//  HolaTaxi
//
//  Created by eslam dweeb on 4/18/18.
//  Copyright © 2018 eslam dweeb. All rights reserved.
//

import UIKit

protocol CenterVCDelegate {
    func toggleLeftPanel()
    func addLeftPanelViewController()
    func animateLeftPanel(shouldExpand: Bool)
}
