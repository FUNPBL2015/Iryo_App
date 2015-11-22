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
    var avatarImageView: UIImageView?
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
        
//        self.contentView.layer.masksToBounds = true
//        self.contentView.layer.cornerRadius = 5.0
        self.contentView.backgroundColor = UIColor.hexStr("FFB5F2", alpha: 1.0)
//        self.contentView.layer.shadowOpacity = 0.5
//        self.contentView.layer.shadowOffset = CGSizeMake(3.0, 3.0)
        
        self.avatarImageView = UIImageView()
//        self.avatarImageView!.layer.masksToBounds = true
//        self.avatarImageView!.layer.cornerRadius = 5.0
        self.avatarImageView!.backgroundColor = UIColor.whiteColor()
        self.avatarImageView!.image = UIImage(named: "AvatarPlaceholder.png")
        self.avatarImageView!.contentMode = UIViewContentMode.ScaleAspectFill
        self.contentView.addSubview(self.avatarImageView!)
        
        self.timestanpLabel = UILabel()
        self.timestanpLabel!.textColor = UIColor.grayColor()
        self.timestanpLabel!.backgroundColor = UIColor.clearColor()
        self.contentView.addSubview(self.timestanpLabel!)

//        self.imageView!.layer.masksToBounds = true
//        self.imageView!.layer.cornerRadius = 5.0
        self.imageView!.backgroundColor = UIColor.blackColor()
        self.imageView!.contentMode = UIViewContentMode.ScaleAspectFit
        
        // MARK: Testing - to the detail screen by tapping
        self.photoButton = UIButton(type: UIButtonType.Custom)
        self.photoButton!.backgroundColor = UIColor.clearColor()
        self.contentView.addSubview(self.photoButton!)
        
        self.comments = UITextView()
//        self.comments!.layer.masksToBounds = true
//        self.comments!.layer.cornerRadius = 5.0
        self.comments!.backgroundColor = UIColor.hexStr("FFDAFD", alpha: 1.0)
        //self.comments!.textAlignment = NSTextAlignment.Center
        self.comments!.font = UIFont.systemFontOfSize(CGFloat(20))
        self.comments!.editable = false
        self.contentView.addSubview(self.comments!)
        
        self.commentField!.borderStyle = UITextBorderStyle.RoundedRect
        self.commentField!.font = UIFont.systemFontOfSize(14.0)
        self.commentField!.placeholder = "コメントを記入..."
        self.commentField!.returnKeyType = UIReturnKeyType.Send
        self.commentField!.textColor = UIColor(red: 34.0/255.0, green: 34.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        self.commentField!.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        self.contentView.addSubview(self.commentField!)
        
        self.commentsReturn!.backgroundColor = UIColor.blueColor()
//        self.commentsReturn!.layer.masksToBounds = true
//        self.commentsReturn!.layer.cornerRadius = 5.0
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
        self.contentView.frame = CGRectMake(myScreenWidth / 10, 30.0, myScreenWidth - myScreenWidth / 5, self.contentView.frame.height - 50)
        self.avatarImageView!.frame = CGRectMake(-20.0, -20.0, 40.0, 40.0)
        self.timestanpLabel!.frame = CGRectMake(self.contentView.frame.width - timestanpLabel!.sizeThatFits(CGSizeMake(myScreenWidth / 2, 20)).width,
            -20, timestanpLabel!.sizeThatFits(CGSizeMake(myScreenWidth / 2, 20)).width, 20)
        self.imageView!.frame = CGRectMake(50.0, 20.0, self.contentView.frame.width - 100, self.contentView.frame.height * 3/5)
        self.photoButton!.frame = self.imageView!.frame
        self.comments!.frame = CGRectMake(50.0, self.imageView!.frame.height + 20 + 10, self.contentView.frame.width - 100, 160)
        self.commentField!.frame = CGRectMake(50.0, self.contentView.frame.height - 30 - 20, self.contentView.frame.width - 100 - 100.0 - 30.0, 30.0 )
        self.commentsReturn!.frame = CGRectMake(self.contentView.frame.width - 50.0 - 100.0 , self.contentView.frame.height - 30 - 20, 100.0, 30.0)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //コメント欄を空にする
        self.commentField!.text = nil
        self.comments!.text = "読み込み中..."
    }
    
}
