//
//  IntentionCell.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/11/21.
//  Copyright © 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit
import ParseUI

class IntentionViewCell: PFTableViewCell{
    
    let mylabel: UILabel! = UILabel()
    var myTextView: UITextView?
    var myPhoto: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.opaque = false
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.accessoryType = UITableViewCellAccessoryType.None
        self.clipsToBounds = false
        
        self.backgroundColor = UIColor.clearColor()
    
        self.contentView.backgroundColor = UIColor.hexStr("0000FF", alpha: 1.0)
        
        self.mylabel.text = "test"
        self.contentView.addSubview(mylabel)
        
        self.myTextView = UITextView()
        self.myTextView!.backgroundColor = UIColor.hexStr("FFDAFD", alpha: 1.0)
        self.myTextView!.font = UIFont.systemFontOfSize(CGFloat(20))
        self.myTextView!.editable = false
        self.contentView.addSubview(self.myTextView!)
        
        self.myPhoto = UILabel()
        self.contentView.addSubview(self.myPhoto!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- UIView
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = CGRectMake(myScreenWidth / 10, 30.0, myScreenWidth - myScreenWidth / 5, self.contentView.frame.height - 50)
        self.mylabel.frame = CGRectMake(0,0,myScreenWidth - myScreenWidth / 5,20)
        self.myTextView!.frame = CGRectMake(0, 20, myScreenWidth - myScreenWidth / 5, self.contentView.frame.height - 150)
        self.myPhoto!.frame = CGRectMake(100, 200, 100, 20)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //コメント欄を空にする
//        self.mylabel.text = nil
//        self.myTextView!.text = nil
    }
    
}
