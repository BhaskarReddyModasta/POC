//
//  NDActivityViewHelper.swift
//  Demo
//
//  Created by FREEMIND on 27/03/17.
//  Copyright © 2017 Owner. All rights reserved.
//

import UIKit

class NDActivityViewHelper: NSObject {
    let indicatorController = NDActivityController()
    var refrenceController = UIViewController()
func startActivity(target:UIViewController) {
            indicatorController.view.frame = CGRect(x: 0, y:0, width: target.view.frame.width, height: target.view.bounds.height)
            target.view.addSubview(indicatorController.view)
 }
 func stopActivity(){
        indicatorController.view.removeFromSuperview()
    }
 }
