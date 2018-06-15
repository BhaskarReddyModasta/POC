//
//  NDActivityController.swift
//  POC
//
//  Created by Admin on 14/06/18.
//  Copyright © 2018 Bhaskar. All rights reserved.
//
import UIKit

internal class NDActivityController: UIViewController {
    
    @IBOutlet weak fileprivate var loadingLabel: UILabel!
    var refrenceController = UIViewController()
    var loadingMessage: String?
    public override func viewDidLoad() {
        super.viewDidLoad()
        if let message = loadingMessage {
            loadingLabel.text = message
        }
    }
    // MARK: Activity loading functions
    func startActivity(target: UIViewController) {
        view.removeFromSuperview()
        view.frame = CGRect(x: 0, y:0, width: target.view.frame.width, height: target.view.bounds.height)
        target.view.addSubview(view)
    }
    
    func stopActivity() {
        view.removeFromSuperview()
    }
}
