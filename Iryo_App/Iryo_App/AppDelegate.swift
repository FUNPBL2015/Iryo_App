//
//  AppDelegate.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室メンバ on 2015/06/10.
//  Copyright (c) 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit
import AVFoundation
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var networkStatus: Reachability.NetworkStatus?
    let speechSynthesizer = AVSpeechSynthesizer()
    var toggle:Bool = true //speakBtnトグル true=Speak,false=Pause
    var myTabBarController: UITabBarController!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        
        
        if !NSUserDefaults.standardUserDefaults().boolForKey("firstLaunch"){
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "firstLaunch")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            // 初回起動時間
            NSUserDefaults.standardUserDefaults().setObject(NSDate(), forKey: "firstTime")
            // talkView すべての要素の順序
            let allObject: [NSString] = []
            NSUserDefaults.standardUserDefaults().setObject(allObject, forKey: "talkViewAllObjects")
            // talkview 投稿以外のセル数
            NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "tipscellnum")
            
        }else{
            // debug
            //NSUserDefaults.standardUserDefaults().removeObjectForKey("firstTime")
            //print("removed firstTime!")
        }
        
        let MainViewController: Top? = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("MainMenu") as? Top
        
        let myNavigationController: UINavigationController = UINavigationController(rootViewController: MainViewController!)
        
        myTabBarController = UITabBarController()
        
        let talkView: TalkView? = TalkView()
        let intentionView: IntentionView? = IntentionView()
        let topicView: TopicView? = TopicView()
        let tipsView: TipsView? = TipsView()
        
        let talkimg = UIImage(named: "Talk.png")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let intentionimg = UIImage(named: "Intention.png")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let topicimg = UIImage(named: "Topic.png")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let tipsimg = UIImage(named: "Tips.png")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        let font:UIFont! = UIFont(name:"07YasashisaGothic",size:16)
        let selectedAttributes:NSDictionary! = [NSFontAttributeName : font, NSForegroundColorAttributeName : UIColor.grayColor()]
        
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes as? [String: AnyObject], forState: .Normal)
        UITabBar.appearance().tintColor = UIColor.grayColor()
        UITabBar.appearance().itemPositioning = .Fill
        UITabBar.appearance().backgroundColor = UIColor.whiteColor()
        
        talkView!.tabBarItem = UITabBarItem(title: "交換写真日記", image: talkimg.thumbnailImage(70, transparentBorder: 0, cornerRadius: 0, interpolationQuality: CGInterpolationQuality.High), tag: 1)
        intentionView!.tabBarItem = UITabBarItem(title: "みんなの意思", image: intentionimg.thumbnailImage(70, transparentBorder: 0, cornerRadius: 0, interpolationQuality: CGInterpolationQuality.High), tag: 2)
        topicView!.tabBarItem =  UITabBarItem(title: "医療トピック", image: topicimg.thumbnailImage(70, transparentBorder: 0, cornerRadius: 0, interpolationQuality: CGInterpolationQuality.High), tag: 3)
        tipsView!.tabBarItem = UITabBarItem(title: "豆知識", image: tipsimg.thumbnailImage(70, transparentBorder: 0, cornerRadius: 0, interpolationQuality: CGInterpolationQuality.High), tag: 4)
        
        let myTabs: NSArray = [talkView!, intentionView!, topicView!, tipsView!]
        
        myTabBarController.setViewControllers(myTabs as? [UIViewController], animated: false)
        
        myTabBarController.selectedViewController = myTabBarController.viewControllers![0]
        
        self.window?.rootViewController = myNavigationController
        
        // MARK: Parse-setting
        Parse.setApplicationId("g3g8USyYIXZgFOOn2N56kVYNFm3mKjplKHg2vUzs",
            clientKey: "Ty1zvkKZGrD5fKioNMMWlF4uh3dsUwKkFpNTbR6t")
        
        return true
    }
    
    func isParseReachable() -> Bool {
        return self.networkStatus != .NotReachable
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

