//
//  PostDetailVC.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/11/18.
//  Copyright © 2015年 b1013075. All rights reserved.
//

import UIKit
import ParseUI
import Parse
import FormatterKit
import ACEDrawingView
import MBProgressHUD
import Synchronized
import UIImage_AF_Additions

@IBDesignable
class PostBtn: UIButton{
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
}

@IBDesignable
class PostSegmentedControl : UISegmentedControl {
    
    @IBInspectable
    var segmentPadding: CGSize = CGSizeZero
    
    @IBInspectable
    var titleFontName: String?
    
    @IBInspectable
    var titleFontSize: CGFloat = UIFont.systemFontSize()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
    setup()
    }

    func setup() {
        var attributes: [NSObject : AnyObject]?
        
        if let fontName = titleFontName, font = UIFont(name: fontName, size: titleFontSize) {
            attributes = [NSFontAttributeName: font]
        }
        
        setTitleTextAttributes(attributes, forState: .Normal)
    }
    
    override func intrinsicContentSize() -> CGSize {
        var size = super.intrinsicContentSize()
        
        if let fontName = titleFontName, let font = UIFont(name: fontName, size: titleFontSize) {
            size.height = floor(font.lineHeight + 2 * segmentPadding.height)
        }
        else {
            size.height += segmentPadding.height * 2
        }
        
        size.width  += segmentPadding.width * CGFloat(numberOfSegments + 1)
        
        return size
    }
}

class PostDetailVC: UIViewController, PaintVCDelegate{
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postSegmented: PostSegmentedControl!
    @IBOutlet weak var postBtn: PostBtn!
    
    private let alert: SCLAlertView = SCLAlertView()
    private var postData: PFObject?
    private var first: Bool = true
    private var fileUploadBackgroundTaskId: UIBackgroundTaskIdentifier! = UIBackgroundTaskInvalid
    var image: UIImage?

    
    private enum Tag: Int{
        case Meal
        case family
        case hobby
        case other
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.postImage.image = self.image!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paintView!.delegate = self
        self.postData = PFObject(className: myChatsClassKey)
        
        self.navigationItem.title = "投稿"
        
        //ボタンの同時押しを禁止する
        self.exclusiveAllTouches()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.postBtn.enabled = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        //インジケーターの非表示
        MBProgressHUD.hideHUDForView(self.navigationController!.view, animated: true)
    }
    
    //TODO: タグ付けを解除するボタンの設置
    @IBAction func didSelectTag(sender: UISegmentedControl) {
        
        let selectedTag = Tag(rawValue: sender.selectedSegmentIndex)!
        
        if self.postData != nil{
            switch selectedTag{
            case .Meal:
                print(selectedTag.rawValue)
//                self.postData!.setObject(selectedTag.rawValue, forKey: myChatsTagKey)
            case .family:
                print(selectedTag.rawValue)
                print("FAMILY")
            case .hobby:
                print(selectedTag.rawValue)
                print("HOBBY")
            case .other:
                print(selectedTag.rawValue)
                print("OTHER")
            }
        }else{
            return
        }
    }

    func paintDidFinish(paintImg: UIImage){
        self.image = paintImg
        self.postImage.image = paintImg
        paintView!.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func didTapOnPaintBtn(sender: AnyObject) {
        // インジケーターの表示
        let hud = MBProgressHUD.showHUDAddedTo(self.navigationController!.view, animated: true)
        hud.dimBackground = true
        
        (sender as! UIButton).enabled = false
        
        if first{
            paintView!.image = self.image
            first = false
        }
        
        // deep copy, subclassが削除される？
        //temp_draw = NSKeyedUnarchiver.unarchiveObjectWithData(NSKeyedArchiver.archivedDataWithRootObject(paintView!.drawingView)) as? ACEDrawingView
        
        temp_undo = paintView!.drawingView.undoSteps
        temp_redo = paintView!.drawingView.redoSteps
        
        self.navigationController?.pushViewController(paintView!, animated: true)
        hud.removeFromSuperview()
    }
    
    @IBAction func showHud(sender: UITapGestureRecognizer){
        // インジケーターの表示
        let hud = MBProgressHUD.showHUDAddedTo(self.navigationController!.view, animated: true)
        hud.dimBackground = true
        
        self.postData!.setObject(postSegmented.selectedSegmentIndex, forKey: myChatsTagKey)
        self.postData!.setObject(PFUser.currentUser()!, forKey: myChatsUserKey)
        
        let imageData: NSData = UIImageJPEGRepresentation(self.postImage.image!, 0.5)!
        let thumbnailImageData: NSData = UIImageJPEGRepresentation(self.postImage.image!, 0.3)!
        
        let photoFile = PFFile(data: imageData)
        let thumbnailFile = PFFile(data: thumbnailImageData)
        
        // Save image
        self.postData!.setObject(photoFile!, forKey: myChatsGraphicFileKey)
        self.postData!.setObject(thumbnailFile!, forKey: myChatsThumbnailKey)
        
        // MARK: カメラロールに保存
        UIImageWriteToSavedPhotosAlbum(self.postImage.image!, nil, nil, nil)
        
        // アラート設定
        self.alert.showCloseButton = false
        self.alert.addButton("OK", action: { () -> Void in
            MBProgressHUD.hideHUDForView(self.navigationController!.view, animated: true)
            print(self.alert.title)
            if self.alert.title == "成功"{
                self.navigationController?.popViewControllerAnimated(true)
            }
        })
        
        self.fileUploadBackgroundTaskId = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler {
            UIApplication.sharedApplication().endBackgroundTask(self.fileUploadBackgroundTaskId)
        }
        
        // タイマーの設置　10秒経っても完了しなければエラー表記
        let timer: NSTimer = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: Selector("handlePostTimeout:"), userInfo: ["post": self.postData!], repeats: false)
        
        self.postData!.saveInBackgroundWithBlock{(succeeded, error) in
            timer.invalidate()
            if succeeded{
                UIApplication.sharedApplication().endBackgroundTask(self.fileUploadBackgroundTaskId)
                NSNotificationCenter.defaultCenter().postNotificationName("TalkView.didFinishEditingPhoto", object: self.postData)
                self.alert.title = "成功"
                self.alert.showSuccess("成功", subTitle:"投稿が完了しました！", closeButtonTitle: "OK")
            }
        }
    }
    
    func handlePostTimeout(aTimer: NSTimer) {
        self.alert.title = "失敗"
        self.alert.showError("エラー", subTitle:"投稿に失敗しました。\nネットワーク接続を確認してください。", closeButtonTitle:"OK")
    }

    
}