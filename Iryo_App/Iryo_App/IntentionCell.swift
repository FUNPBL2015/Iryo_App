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
    
    var avatarImageView: UIImageView?
    var timestanpLabel: UILabel?
    var sankaku:UILabel?
    var titleLabel: UILabel?
    var tipsLabel: UILabel?
    var cellheight: CGFloat?
    var Ybutton: UIButton? = UIButton()
    var Nbutton: UIButton? = UIButton()
    
    //let tipText:String = "飲み込みが悪くなるなど、口から食事が難しなった時に、胃ろうや経鼻経管栄養、点滴を行いたいですか？"
    var tipText:String?
    
    var contentWidth = CGFloat()
    var contentHeight = CGFloat()
    var titleWidth = CGFloat()
    var titleHeight = CGFloat()
    var tipTextSize = CGRect(x: 0,y: 0,width: 0,height: 0)
    var tipWidth = CGFloat()
    var tipHeight = CGFloat()
    var margin = CGFloat()
    
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
        //self.tipsLabel!.text = tipText
        self.tipsLabel!.backgroundColor = UIColor.yellowColor()
        self.contentView.addSubview(self.tipsLabel!)
        
        self.titleLabel = UILabel()
        //self.titleLabel!.text = "意思の記録"
        //self.titleLabel!.backgroundColor = UIColor.whiteColor()
        self.titleLabel!.font = UIFont.systemFontOfSize(CGFloat(26))
        self.contentView.addSubview(self.titleLabel!)
        
        self.sankaku = UILabel()
        self.sankaku!.text = "◀︎"
        self.sankaku!.textColor = UIColor.hexStr("7fff7f", alpha: 1.0)
        self.sankaku!.font = UIFont.systemFontOfSize(CGFloat(26))
        self.contentView.addSubview(self.sankaku!)
        
        self.Ybutton!.backgroundColor = UIColor(red: 255.0/255.0, green: 68.0/255.0, blue: 31.0/255.0, alpha: 1.0)
        self.Ybutton!.layer.masksToBounds = true
        self.Ybutton!.layer.cornerRadius = 5.0
        self.Ybutton!.setTitle("はい", forState: UIControlState.Normal)
        self.Ybutton!.titleLabel?.textColor = UIColor.whiteColor()
        self.contentView.addSubview(self.Ybutton!)
        
        self.Nbutton!.backgroundColor = UIColor(red: 30.0/255.0, green: 144.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        self.Nbutton!.layer.masksToBounds = true
        self.Nbutton!.layer.cornerRadius = 5.0
        self.Nbutton!.setTitle("いいえ", forState: UIControlState.Normal)
        self.Nbutton!.titleLabel?.textColor = UIColor.whiteColor()
        self.contentView.addSubview(self.Nbutton!)
        
//        //以下はtextから高さを取得する処理
//        //改行を単語区切りに
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping
//        //NSAttributedStringのAttributeを指定
//        let tipAttributeDict = [
//            NSFontAttributeName: UIFont.systemFontOfSize(20),
//            NSParagraphStyleAttributeName: paragraphStyle
//        ]
        
        //各要素の高さと幅の宣言
        margin = 15.0
        contentWidth = myScreenWidth - myScreenWidth / 5
        //let tipConstraintsSize = CGSizeMake(contentWidth - margin*4, 1000)
        //print(self.tipsLabel?.text)
        //tipTextSize = NSString(string: tipText!).boundingRectWithSize(tipConstraintsSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: tipAttributeDict, context: nil)
        titleWidth = contentWidth - margin*2
        titleHeight = 40.0
        contentHeight = titleHeight + tipTextSize.height + margin*4 + 60
        tipWidth = contentWidth - margin*4
        tipHeight = tipTextSize.height
        
        self.cellheight = contentHeight + margin*4
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK:- UIView
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.contentView.frame = CGRectMake(myScreenWidth / 10, 30.0, contentWidth, titleHeight + tipTextSize.height + margin*5)
        //self.cellheight = titleHeight + tipTextSize.height + margin*8
        self.avatarImageView!.frame = CGRectMake(-70.0, 20.0, 50.0, 50.0)
        self.sankaku!.frame = CGRectMake(-20.0, 20.0, 50.0, 50.0)
        self.timestanpLabel!.frame = CGRectMake(contentWidth - timestanpLabel!.sizeThatFits(CGSizeMake(myScreenWidth / 2, 20)).width,
            -20, timestanpLabel!.sizeThatFits(CGSizeMake(myScreenWidth / 2, 20)).width, 20)
        self.titleLabel!.frame = CGRectMake(margin, margin, titleWidth, titleHeight)
        self.tipsLabel!.frame = CGRectMake(margin*2, self.titleLabel!.frame.height + margin, tipWidth, tipTextSize.height)
        //print("check: " + String(tipTextSize!.height))
        self.Ybutton!.frame = CGRectMake(margin*3, self.tipsLabel!.frame.maxY, contentWidth/2 - margin*6, 40)
        self.Nbutton!.frame = CGRectMake(contentWidth/2 + margin*3, self.tipsLabel!.frame.maxY, self.Ybutton!.frame.width, 40)
        
    }
    
}


