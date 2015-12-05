//
//  CustomCell.swift
//  Iryo_App
//
//  Created by member on 2015/10/22.
//  Copyright © 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    @IBOutlet var imgSample:UIImageView!

    @IBOutlet var userPicture: UIImageView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        imgSample.contentMode = UIViewContentMode.ScaleAspectFit
    }
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
}
