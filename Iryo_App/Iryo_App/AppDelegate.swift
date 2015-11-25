//
//  AppDelegate.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室メンバ on 2015/06/10.
//  Copyright (c) 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var networkStatus: Reachability.NetworkStatus?
    
    let speechSynthesizer = AVSpeechSynthesizer()
    var toggle:Bool = true //speakBtnトグル true=Speak,false=Pause
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        
        let MainViewController: Top? = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("MainMenu") as? Top
        
        let myNavigationController: UINavigationController = UINavigationController(rootViewController: MainViewController!)

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

