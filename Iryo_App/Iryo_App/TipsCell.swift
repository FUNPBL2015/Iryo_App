//
//  TipsCell.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/11/21.
//  Copyright © 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit
import ParseUI

class TipsViewCell: PFTableViewCell{
    
    var avatarImageView: UIImageView?
    var timestanpLabel: UILabel?
    var sankaku:UILabel?
    var titleLabel: UILabel?
    var tipsLabel: UILabel?
    var cellheight: CGFloat?
    
    var contentWidth = CGFloat()
    var contentHeight = CGFloat()
    var titleWidth = CGFloat()
    var titleHeight = CGFloat()
    var tipTextSize = CGRect()
    var tipWidth = CGFloat()
    var tipHeight = CGFloat()
    var margin = CGFloat()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.opaque = false
        self.selectionStyle = UITableViewCellSelectionStyle.Default
        self.accessoryType = UITableViewCellAccessoryType.None
        self.clipsToBounds = false
        
        let bg = UIView()
        bg.backgroundColor = UIColor.redColor()
        self.selectedBackgroundView = bg
        
        self.backgroundColor = UIColor.clearColor()
        
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 15.0
        self.contentView.backgroundColor = UIColor.hexStr("7fff7f", alpha: 1.0)
        self.contentView.layer.shadowOpacity = 0.5
        self.contentView.layer.shadowOffset = CGSizeMake(3.0, 3.0)
        self.contentView.layer.shadowRadius = 3.0
        
        self.avatarImageView = UIImageView()
        self.avatarImageView!.backgroundColor = UIColor.clearColor()
        self.avatarImageView!.image = UIImage(named: "cat.png")
        self.avatarImageView!.contentMode = UIViewContentMode.ScaleAspectFill
        self.contentView.addSubview(self.avatarImageView!)
        
        self.timestanpLabel = UILabel()
        self.timestanpLabel!.textColor = UIColor.grayColor()
        self.timestanpLabel!.backgroundColor = UIColor.clearColor()
        self.timestanpLabel!.text = "2015/00/00 00:00"
        self.contentView.addSubview(self.timestanpLabel!)
        
        self.tipsLabel = UILabel()
        self.tipsLabel!.font = UIFont.systemFontOfSize(CGFloat(20))
        self.tipsLabel!.numberOfLines = 0
        //self.tipsLabel!.backgroundColor = UIColor.yellowColor()
        self.contentView.addSubview(self.tipsLabel!)
        
        self.titleLabel = UILabel()
        //self.titleLabel!.backgroundColor = UIColor.whiteColor()
        self.titleLabel!.font = UIFont.systemFontOfSize(CGFloat(26))
        self.contentView.addSubview(self.titleLabel!)
        
        self.sankaku = UILabel()
        self.sankaku!.text = "◀︎"
        self.sankaku!.textColor = UIColor.hexStr("7fff7f", alpha: 1.0)
        self.sankaku!.font = UIFont.systemFontOfSize(CGFloat(26))
        self.contentView.addSubview(self.sankaku!)
        
        //各要素の高さと幅の宣言
        margin = 15.0
        contentWidth = myScreenWidth - myScreenWidth / 5
        titleWidth = contentWidth - margin*2
        titleHeight = 40.0
        contentHeight = titleHeight + tipTextSize.height + margin*2
        tipWidth = contentWidth - margin*4
        tipHeight = tipTextSize.height
        
        self.cellheight = contentHeight + margin*4 + 100
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- UIView
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.frame = CGRectMake(myScreenWidth / 10, 30.0, contentWidth, titleHeight + tipTextSize.height + margin*2)
        self.cellheight = titleHeight + tipTextSize.height + margin*4 + margin*4
        self.avatarImageView!.frame = CGRectMake(-70.0, 20.0, 50.0, 50.0)
        self.sankaku!.frame = CGRectMake(-20.0, 20.0, 50.0, 50.0)
        self.timestanpLabel!.frame = CGRectMake(contentWidth - timestanpLabel!.sizeThatFits(CGSizeMake(myScreenWidth / 2, 20)).width,
            -20, timestanpLabel!.sizeThatFits(CGSizeMake(myScreenWidth / 2, 20)).width, 20)
        self.titleLabel!.frame = CGRectMake(margin, margin, titleWidth, titleHeight)
        self.tipsLabel!.frame = CGRectMake(margin*2, self.titleLabel!.frame.height + margin, tipWidth, tipTextSize.height)
        
    }
    
}
