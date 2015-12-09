//
//  BaseTalkViewCell.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/10/30.
//  Copyright © 2015年 b1013075. All rights reserved.
//

import UIKit
import QuartzCore
import ParseUI

class TalkViewCell: PFTableViewCell{
    var avatarImageView: PFImageView?
    var avatarBackGroundView: UIView?
    var userName: UILabel?
    var timestanpLabel: UILabel?
    var photoButton: UIButton?
    var comments: UITextView?
    var commentField: UITextField? = UITextField()
    var commentsReturn: UIButton? = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        self.opaque = false
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.accessoryType = UITableViewCellAccessoryType.None
        self.clipsToBounds = false
        
        self.backgroundColor = UIColor.clearColor()
        
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.backgroundColor = UIColor.hexStr("FFB5F2", alpha: 1.0)

        self.contentView.layer.shouldRasterize = true
        self.contentView.layer.rasterizationScale = UIScreen.mainScreen().scale
        self.contentView.layer.shadowOpacity = 0.5
        self.contentView.layer.shadowOffset = CGSizeMake(3.0, 3.0)
        self.contentView.layer.shadowRadius = 3.0
        
        self.avatarImageView = PFImageView()
        self.avatarImageView!.backgroundColor = UIColor.clearColor()
        self.avatarImageView!.contentMode = UIViewContentMode.ScaleAspectFill
        self.avatarImageView!.frame = CGRectMake(25.0, 5.0, 30.0, 70.0)
        
        self.userName = UILabel()
        self.userName!.frame = CGRectMake(5.0, 80.0, 70, 16)
        self.userName!.font = UIFont(name: "07YasashisaGothic", size: 14)
        self.userName!.textAlignment = .Center
        
        self.avatarBackGroundView = UIView()
        self.avatarBackGroundView!.backgroundColor = UIColor.hexStr("FF83A8", alpha: 1.0)
        self.avatarBackGroundView!.addSubview(self.userName!)
        self.avatarBackGroundView!.addSubview(self.avatarImageView!)
        self.contentView.addSubview(self.avatarBackGroundView!)
        
        self.timestanpLabel = UILabel()
        self.timestanpLabel!.font = UIFont(name: "07YasashisaGothic", size: 20)
        self.timestanpLabel!.textColor = UIColor.grayColor()
        self.timestanpLabel!.backgroundColor = UIColor.clearColor()
        self.contentView.addSubview(self.timestanpLabel!)

        self.imageView!.layer.masksToBounds = true
        self.imageView!.layer.cornerRadius = 5.0
        self.imageView!.backgroundColor = UIColor.clearColor()
        self.imageView!.contentMode = UIViewContentMode.ScaleAspectFit
        
        self.photoButton = UIButton(type: UIButtonType.Custom)
        self.photoButton!.backgroundColor = UIColor.clearColor()
        self.contentView.addSubview(self.photoButton!)
        
        self.comments = UITextView()
        self.comments!.layer.masksToBounds = true
        self.comments!.layer.cornerRadius = 5.0
        self.comments!.backgroundColor = UIColor.hexStr("FFDAFD", alpha: 1.0)
        //self.comments!.textAlignment = NSTextAlignment.Center
        self.comments!.font = UIFont(name: "07YasashisaGothic", size: 20)
        //self.comments!.font = UIFont.(CGFloat(20))
        self.comments!.text = "読み込み中..."
        self.comments!.editable = false
        self.contentView.addSubview(self.comments!)
        
        self.commentField!.borderStyle = UITextBorderStyle.RoundedRect
        self.commentField!.font = UIFont.systemFontOfSize(14.0)
        self.commentField!.placeholder = "コメントを記入..."
        self.commentField!.returnKeyType = UIReturnKeyType.Send
        self.commentField!.textColor = UIColor(red: 34.0/255.0, green: 34.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        self.commentField!.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        self.contentView.addSubview(self.commentField!)
        
        self.commentsReturn!.backgroundColor = UIColor.hexStr("4597F5", alpha: 1.0)
        self.commentsReturn!.layer.masksToBounds = true
        self.commentsReturn!.layer.cornerRadius = 5.0
        self.commentsReturn!.setTitle("コメント", forState: UIControlState.Normal)
        self.commentsReturn!.titleLabel?.textColor = UIColor.whiteColor()
        self.contentView.addSubview(self.commentsReturn!)
        
        self.contentView.bringSubviewToFront(self.imageView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- UIView
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = CGRectMake(myScreenWidth / 10, 70.0, myScreenWidth - myScreenWidth / 5, self.contentView.frame.height - 70)
        //self.avatarImageView!.frame = CGRectMake(-15.0, -35.0, 30.0, 70.0)
        self.avatarBackGroundView!.frame = CGRectMake(-40.0, -40.0, 80.0, 100.0)
        self.timestanpLabel!.frame = CGRectMake(self.contentView.frame.width - timestanpLabel!.sizeThatFits(CGSizeMake(myScreenWidth / 2, 20)).width,
            -25.0, timestanpLabel!.sizeThatFits(CGSizeMake(myScreenWidth / 2, 20)).width, 20)
        self.imageView!.frame = CGRectMake(50.0, 20.0, self.contentView.frame.width - 100, self.contentView.frame.height * 3/5)
        self.photoButton!.frame = self.imageView!.frame
        self.comments!.frame = CGRectMake(50.0, self.imageView!.frame.height + 20 + 10, self.contentView.frame.width - 100, 160)
        self.commentField!.frame = CGRectMake(50.0, self.contentView.frame.height - 30 - 15, self.contentView.frame.width - 100 - 100.0 - 30.0, 30.0 )
        self.commentsReturn!.frame = CGRectMake(self.contentView.frame.width - 50.0 - 100.0 , self.contentView.frame.height - 30 - 15, 100.0, 30.0)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //コメント欄を空にする
        self.avatarImageView!.image = UIImage(named: "AvatarPlaceholder.png")
        self.commentField!.text = nil
        //self.comments!.text = ""
    }
    
}
