
//
//  WelcomeTalkVC.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/11/19.
//  Copyright © 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit
import Parse

class WelcomeTalkVC: UIViewController{
    @IBOutlet weak var userNameTextfield: UITextField!
    @IBOutlet weak var userPasswordTextfield: UITextField!
    let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    private var avater: UIImage?
    
    private enum Relationship: Int{
        case aunt
        case uncle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //TODO: sign in/up の切り替え
    //TODO: avater画像の設定
    //TODO: textfield　ログイン中の処理
    
    @IBAction func didSelectTag(sender: UISegmentedControl) {
        
        let selectedTag = Relationship(rawValue: sender.selectedSegmentIndex)!
        
        switch selectedTag{
        case .aunt:
            self.avater = UIImage(named: "aunt.png")
            print(self.avater)
            print(selectedTag.rawValue)
        case .uncle:
            self.avater = UIImage(named: "uncle.png")
            print(self.avater)
            print(selectedTag.rawValue)
        }
    }
    
    func signIn(username:NSString, password:NSString) {
        PFUser.logInWithUsernameInBackground(username as String, password: password as String,
            block: {(user, error) in
            if user != nil{
                if let a = self.avater {
                    let av = PFFile(data: UIImagePNGRepresentation(a)!)
                    PFUser.currentUser()!.setObject(av!, forKey: myUserProfilePicSmallKey)
                    PFUser.currentUser()!.saveInBackground()
                }
                self.navigationController?.setViewControllers([mainView!, self.delegate.myTabBarController], animated: true)
            }else{
                SCLAlertView().showError("Incorrect Password", subTitle:"Error エラー Error エラー Error エラー Error エラー Error エラー Error エラー Error エラー Error エラー Error エラー ", closeButtonTitle:"OK")
            }
        })
    }
    
    func signUp(user:PFUser) {
        user.signUpInBackgroundWithBlock{ (success, error) in
            if error == nil {
                self.navigationController?.setViewControllers([mainView!, self.delegate.myTabBarController], animated: true)
                if let a = self.avater {
                    let av = PFFile(data: UIImagePNGRepresentation(a)!)
                    PFUser.currentUser()!.setObject(av!, forKey: myUserProfilePicSmallKey)
                    PFUser.currentUser()!.saveInBackground()
                }
            }else{
                let errorString = error!.userInfo["error"] as! NSString
                SCLAlertView().showError(errorString as String, subTitle:"Error エラー Error エラー Error エラー Error エラー Error エラー Error エラー Error エラー Error エラー Error エラー ", closeButtonTitle:"OK")
            }
        }
    }
    
    @IBAction func didTapOnLogin(sender: AnyObject) {
        let user: PFUser! = PFUser()
        user!.username = self.userNameTextfield.text
        user!.password = self.userPasswordTextfield.text
        
        let checkExist: PFQuery? = PFUser.query()
        checkExist!.whereKey("username", equalTo: user.username!)
        checkExist!.findObjectsInBackgroundWithBlock { (objects, error) in
            // 正規表現チェック　ここでID,PWの長さや無効な文字列を設定する
            if  self.userPasswordTextfield.text!.length < 4 ||
                Regexp("[ 　]").isMatch(self.userPasswordTextfield.text!) ||
                Regexp("[ 　%*+=\\[\\]/|;:\\\"<>?,@]").isMatch(self.userNameTextfield.text!) {
                SCLAlertView().showError("Check your password length", subTitle:"Error エラー Error エラー Error エラー Error エラー Error エラー Error エラー Error エラー Error エラー Error エラー ", closeButtonTitle:"OK")
            }else if(objects!.count > 0){
                self.signIn(user.username!, password:user.password!)
            } else {
                self.signUp(user)
            }
        }
    }
}