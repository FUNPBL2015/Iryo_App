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

    
    override init(frame: CGRect){
        super.init(frame: frame)
        
//        titleSample = UILabel(frame: CGRectMake(0, 0, frame.width, frame.height))
//        titleSample.text = "nil"
//        titleSample.backgroundColor = UIColor.whiteColor()
//        titleSample.textAlignment = NSTextAlignment.Center
        
    }
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
}
