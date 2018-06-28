//
//  CanadaListTableViewCell.swift
//  POC
//
//  Created by Admin on 18/06/18.
//  Copyright © 2018 Bhaskar. All rights reserved.
//

import UIKit

class CanadaListTableViewCell: UITableViewCell {

    let imageViewCustom = UIImageView()
    let detailLabel = UILabel()
    
    // MARK: Initalizers
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        // configure imageViewCustom
        contentView.addSubview(imageViewCustom)
        imageViewCustom.translatesAutoresizingMaskIntoConstraints = false
        imageViewCustom.heightAnchor.constraint(equalTo: imageViewCustom.widthAnchor, multiplier: 1.0/2.0).isActive = true
        imageViewCustom.contentMode = .scaleAspectFit
        imageViewCustom.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        imageViewCustom.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        imageViewCustom.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true

        // configure detailLabel
        contentView.addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        detailLabel.topAnchor.constraint(equalTo: imageViewCustom.bottomAnchor).isActive = true
        detailLabel.numberOfLines = 0
        detailLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
    }
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
