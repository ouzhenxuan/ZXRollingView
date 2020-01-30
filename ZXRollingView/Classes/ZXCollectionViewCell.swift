//
//  ZXCollectionViewCell.swift
//  ZXRollingControl
//
//  Created by ozx on 2020/1/29.
//  Copyright © 2020 ozx. All rights reserved.
//

import UIKit

class ZXCollectionViewCell: UICollectionViewCell {
    
    public var textLabel:UILabel = UILabel.init();
    
    convenience   required   init(coder : NSCoder){
        self.init()
    }
    
    override  init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        textLabel.backgroundColor = UIColor.yellow
        textLabel.font = UIFont.systemFont(ofSize: 30)
        textLabel.textColor = UIColor.black
        textLabel.text = "de"
        self.addSubview(textLabel);
        
        textLabel.frame = self.bounds
        print( self.frame)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
