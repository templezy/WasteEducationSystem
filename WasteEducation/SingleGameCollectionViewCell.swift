//
//  SingleGameCollectionViewCell.swift
//  WasteEducation
//
//  Created by ZhouYue on 9/01/2016.
//  Copyright © 2016 ZhouYue. All rights reserved.
//

import UIKit

class SingleGameCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    var textLabel: UILabel!
    var imageButton: UIButton!
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageButton = UIButton(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.width))
        imageButton.contentMode = UIViewContentMode.ScaleToFill
        contentView.addSubview(imageButton)
        
        textLabel = UILabel(frame: CGRect(x: 0, y: imageButton.frame.size.height/2, width: frame.size.width, height: frame.size.height/3))
        textLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 17.0)
        textLabel.textAlignment = .Center
        textLabel.textColor = UIColor.whiteColor()
        contentView.addSubview(textLabel)
        
        self.backgroundColor = UIColor.blueColor()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
