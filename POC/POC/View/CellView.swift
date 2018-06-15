//
//  CellView.swift
//  POC
//
//  Created by Admin on 13/06/18.
//  Copyright © 2018 Bhaskar. All rights reserved.
//

import Foundation
import UIKit

class CellView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    var bgView : UIView = UIView()
    var gridImgView : UIImageView = UIImageView()
    var gridLabel : UILabel = UILabel()
    var gridDescriptionLabel : UILabel = UILabel()
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        // Initialization code
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    func loadView(frame: CGRect) {
        self.bgView.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height)
        self.bgView.backgroundColor = .white
        
        self.gridImgView.frame=CGRect(x:5 , y:5, width:self.bgView.frame.size.width - 10, height:250)
        self.gridImgView.contentMode = .scaleAspectFit
        self.gridImgView.clipsToBounds = true
        self.bgView.addSubview(self.gridImgView)
        
        self.gridLabel.frame=CGRect(x:5, y:self.gridImgView.frame.maxY, width:self.gridImgView.frame.size.width, height:30)
        self.gridLabel.backgroundColor = UIColor.white
        self.gridLabel.font = UIFont.boldSystemFont(ofSize: 24)
        self.gridLabel.textColor = UIColor.black
        self.gridLabel.textAlignment = NSTextAlignment.left
        self.bgView.addSubview(self.gridLabel)
        
        self.gridDescriptionLabel.frame = CGRect(x:5, y:self.gridLabel.frame.maxY, width:self.gridImgView.frame.size.width, height:frame.size.height - 280)
        self.gridDescriptionLabel.backgroundColor = UIColor.white
        self.gridDescriptionLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.gridDescriptionLabel.textColor = UIColor.darkGray
        self.gridDescriptionLabel.textAlignment = NSTextAlignment.left
        self.gridDescriptionLabel.numberOfLines = 0
        self.bgView.addSubview(self.gridDescriptionLabel)
        self.addSubview(self.bgView)

    }

}
