//
//  NDActivityController.swift
//  POC
//
//  Created by Admin on 14/06/18.
//  Copyright © 2018 Bhaskar. All rights reserved.
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
