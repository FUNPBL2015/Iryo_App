//
//  TopicCell.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/11/21.
//  Copyright © 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit
import ParseUI

class TopicViewCell: PFTableViewCell{
    
    var avatarImageView: UIImageView?
    var timestanpLabel: UILabel?
    var sankaku:UILabel?
    var titleLabel: UILabel?
    var tipsLabel: UILabel?
    var comments: UITextView?
    var commentField: UITextField? = UITextField()
    var commentsReturn: UIButton? = UIButton()
    
    let tipText:String = "TEST!TEST!TEST!TEST!TEST!TEST!TEST!\n\n\n\n\n\n\ntopic: "
    
    var contentWidth = CGFloat()
    var contentHeight = CGFloat()
    var titleWidth = CGFloat()
    var titleHeight = CGFloat()
    var tipTextSize = CGRect()
    var tipWidth = CGFloat()
    var tipHeight = CGFloat()
    var margin = CGFloat()
    var cellheight: CGFloat?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.opaque = false
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.accessoryType = UITableViewCellAccessoryType.None
        self.clipsToBounds = false
        
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
        self.contentView.addSubview(self.timestanpLabel!)
        
        self.tipsLabel = UILabel()
        self.tipsLabel!.font = UIFont.systemFontOfSize(CGFloat(20))
        self.tipsLabel!.numberOfLines = 0
        self.tipsLabel!.text = tipText
        //self.tipsLabel!.backgroundColor = UIColor.yellowColor()
        self.contentView.addSubview(self.tipsLabel!)
        
        self.titleLabel = UILabel()
        self.titleLabel!.text = "TOPIC!"
        //self.titleLabel!.backgroundColor = UIColor.whiteColor()
        self.titleLabel!.font = UIFont.systemFontOfSize(CGFloat(26))
        self.contentView.addSubview(self.titleLabel!)
        
        self.sankaku = UILabel()
        self.sankaku!.text = "◀︎"
        self.sankaku!.textColor = UIColor.hexStr("7fff7f", alpha: 1.0)
        self.sankaku!.font = UIFont.systemFontOfSize(CGFloat(26))
        self.contentView.addSubview(self.sankaku!)
        
        self.comments = UITextView()
        self.comments!.layer.masksToBounds = true
        self.comments!.layer.cornerRadius = 5.0
        self.comments!.backgroundColor = UIColor.hexStr("FFFFFF", alpha: 0.6)
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
        
        self.commentsReturn!.backgroundColor = UIColor(red: 30.0/255.0, green: 144.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        self.commentsReturn!.layer.masksToBounds = true
        self.commentsReturn!.layer.cornerRadius = 5.0
        self.commentsReturn!.setTitle("コメント", forState: UIControlState.Normal)
        self.commentsReturn!.titleLabel?.textColor = UIColor.whiteColor()
        self.contentView.addSubview(self.commentsReturn!)
        
        
        //以下はtextから高さを取得する処理
        //改行を単語区切りに
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping
        //NSAttributedStringのAttributeを指定
        let tipAttributeDict = [
            NSFontAttributeName: UIFont.systemFontOfSize(20),
            NSParagraphStyleAttributeName: paragraphStyle
        ]
        
        //各要素の高さと幅の宣言
        margin = 15.0
        contentWidth = myScreenWidth - myScreenWidth / 5
        //高さを取得するための領域サイズの指定　高さは仮
        let tipConstraintsSize = CGSizeMake(contentWidth - margin*4, 1000)
        //テキストから高さを取得
        tipTextSize = NSString(string: tipText).boundingRectWithSize(tipConstraintsSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: tipAttributeDict, context: nil)
        titleWidth = contentWidth - margin*2
        titleHeight = 40.0
        contentHeight = titleHeight + tipTextSize.height + margin*4 + 190
        tipWidth = contentWidth - margin*4
        tipHeight = tipTextSize.height
        //cellの高さ
        self.cellheight = contentHeight + margin*4
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- UIView
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.contentView.frame = CGRectMake(myScreenWidth / 10, 30.0, contentWidth, contentHeight)
        self.avatarImageView!.frame = CGRectMake(-70.0, 20.0, 50.0, 50.0)
        self.sankaku!.frame = CGRectMake(-20.0, 20.0, 50.0, 50.0)
        self.timestanpLabel!.frame = CGRectMake(contentWidth - timestanpLabel!.sizeThatFits(CGSizeMake(myScreenWidth / 2, 20)).width,
            -20, timestanpLabel!.sizeThatFits(CGSizeMake(myScreenWidth / 2, 20)).width, 20)
        self.titleLabel!.frame = CGRectMake(margin, margin, titleWidth, titleHeight)
        self.tipsLabel!.frame = CGRectMake(margin*2, self.titleLabel!.frame.height + margin, tipWidth, tipHeight)
        self.comments!.frame = CGRectMake(margin, self.titleLabel!.frame.height + self.tipsLabel!.frame.height + margin*2, contentWidth - margin*2, 160)
        self.commentField!.frame = CGRectMake(margin, self.titleLabel!.frame.height + self.tipsLabel!.frame.height + self.comments!.frame.height + margin*3 , contentWidth - margin*10, 30.0)
        self.commentsReturn!.frame = CGRectMake(self.commentField!.frame.width + margin*2, self.commentField!.frame.minY, 100.0, 30.0)
    }
}
