//
//  CustomCell.swift
//  Iryo_App
//
//  Created by member on 2015/10/22.
//  Copyright © 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    @IBOutlet var imgSample:UIImageView?

    @IBOutlet var userPicture: UIImageView?
    @IBOutlet var userName: UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    
    override func prepareForReuse() {
        if self.imgSample != nil {
            self.imgSample!.image = nil
        }
        if self.userPicture != nil {
            self.userPicture!.image = nil
        }
    }
}
