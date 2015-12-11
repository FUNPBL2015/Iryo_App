//
//  TestCell.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/12/10.
//  Copyright © 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit
import ParseUI

@IBDesignable
class CellView: UIView{
    @IBInspectable var cornerRadius: CGFloat = 0.0{
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.0{
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSizeMake(0.0, 0.0){
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0.0{
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
}

class TestCell: PFTableViewCell{
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib(){
        super.awakeFromNib()
        
        self.opaque = false
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.accessoryType = UITableViewCellAccessoryType.None
        self.clipsToBounds = false
        
        self.contentView.autoresizingMask = autoresizingMask
    }
}
