//
//  Constants.swift
//  Paint
//
//  Created by 伊藤恵研究室 on 2015/10/30.
//  Copyright © 2015年 b1013075. All rights reserved.
//

// MARK: Device-Info
let myScreenWidth = UIScreen.mainScreen().bounds.width
let myScreenHeight = UIScreen.mainScreen().bounds.height
let myStatusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height

func navigationBarHeight(callFrom: UIViewController) -> CGFloat? {
    return callFrom.navigationController?.navigationBar.frame.size.height ?? 44
}

// MARK: Chats-Class
// Class-key
let myChatsClassKey = "chats"

// Field-keys
let myChatsGraphicFileKey = "graphicFile"
let myChatsThumbnailKey = "thumbnail"

// MARK: Activity-Class
//Class-key
let myActivityClassKey = "Activity_02"

// Field-keys
let myActivityContentKey = "content"
let myActivityTypeKey = "type"
let myActivityPhotoKey = "photo"