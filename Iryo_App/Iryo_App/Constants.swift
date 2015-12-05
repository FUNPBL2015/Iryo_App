//
//  Constants.swift
//  Paint
//
//  Created by 伊藤恵研究室 on 2015/10/30.
//  Copyright © 2015年 b1013075. All rights reserved.
//

import UIKit
import ACEDrawingView

// MARK: Device-Info
let myScreenWidth = UIScreen.mainScreen().bounds.width
let myScreenHeight = UIScreen.mainScreen().bounds.height
let myStatusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height

func navigationBarHeight(callFrom: UIViewController) -> CGFloat? {
    return callFrom.navigationController?.navigationBar.frame.size.height ?? 60
}

//  MARK: Views
// Storyboards
let mainView: Top? = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("MainMenu") as? Top
//let welcomeTalkView: WelcomeTalkVC? = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("WelcomeTalkVC") as? WelcomeTalkVC
//let postDetailView: PostDetailVC? = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("PostDetailVC") as? PostDetailVC
var paintView: PaintVC? = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("PaintVC") as? PaintVC
var temp_undo: UInt?
var temp_redo: UInt?

// CommunicateViews
//let talkView: TalkView? = TalkView()
//let intentionView: IntentionView? = IntentionView()
//let topicView: TopicView? = TopicView()
//let tipsView: TipsView? = TipsView()


// MARK: Chats-Class
// Class-key
let myChatsClassKey = "chats"

// Field-keys
let myChatsGraphicFileKey = "graphicFile"
let myChatsThumbnailKey = "thumbnail"
let myChatsTagKey = "tag"
let myChatsUserKey = "user"


// MARK: Activity-Class
//Class-key
let myActivityClassKey = "Activity_02"

// Field-keys
let myActivityContentKey = "content"
let myActivityTypeKey = "type"
let myActivityPhotoKey = "photo"
let myActivityFromUserKey = "fromUser"

// MARK: User-Class
// User-keys
let myUserProfilePicSmallKey = "profilePictureSmall"

// 正規表現
class Regexp {
    let internalRegexp: NSRegularExpression
    let pattern: String
    
    init(_ pattern: String) {
        self.pattern = pattern
        do {
            self.internalRegexp = try NSRegularExpression(pattern: pattern, options: [])
        } catch let error as NSError {
            print(error.localizedDescription)
            self.internalRegexp = NSRegularExpression()
        }
    }
    
    func isMatch(input: String) -> Bool {
        let matches = self.internalRegexp.matchesInString(input, options:[], range:NSMakeRange(0, input.characters.count) )
        return matches.count > 0
    }
    
    func matches(input: String) -> [String]? {
        if self.isMatch(input) {
            let matches = self.internalRegexp.matchesInString( input, options: [], range:NSMakeRange(0, input.characters.count) )
            var results: [String] = []
            for i in 0 ..< matches.count {
                results.append( (input as NSString).substringWithRange(matches[i].range) )
            }
            return results
        }
        return nil
    }
    
    func delMatches(input:String) -> String {
        var strRet:String = input
        if self.isMatch(input) {
            let matchList = self.matches(input)
            for var i = 0; i < matchList!.count; i++ {
                strRet = strRet.stringByReplacingOccurrencesOfString(matchList![i], withString: "", options: [], range: nil)
            }
        }
        return strRet
    }
}