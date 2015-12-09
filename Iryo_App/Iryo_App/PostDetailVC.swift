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
        
        (sender as! UIButton).enabled = true
        
    }

    // TODO: インジケータの表示
    // TODO: ネットワーク切断時のタイマー設定　（デフォルトでは長時間なので短時間に、コメント投稿部分では実装済み）
    @IBAction func didTapOnPostBtn(sender: AnyObject) {
        self.postData!.setObject(postSegmented.selectedSegmentIndex, forKey: myChatsTagKey)
        self.postData!.setObject(PFUser.currentUser()!, forKey: myChatsUserKey)
        
        let resizedImgge: UIImage = self.postImage.image!.resizedImageWithContentMode(UIViewContentMode.ScaleAspectFit, bounds: CGSizeMake(self.postImage.image!.size.width , self.postImage.image!.size.height), interpolationQuality: CGInterpolationQuality.High)
        let thumbnailImage: UIImage = self.postImage.image!.resizedImageWithContentMode(UIViewContentMode.ScaleAspectFit, bounds: CGSizeMake(self.postImage.frame.width, self.postImage.frame.height), interpolationQuality: CGInterpolationQuality.Default)
        //let thumbnailImage: UIImage = self.postImage.image!.thumbnailImage(256, transparentBorder: 0, cornerRadius: 10, interpolationQuality: CGInterpolationQuality.Medium)
        
        let imageData: NSData = UIImagePNGRepresentation(resizedImgge)!
        let thumbnailImageData: NSData = UIImagePNGRepresentation(thumbnailImage)!
        
        let photoFile = PFFile(data: imageData)
        let thumbnailFile = PFFile(data: thumbnailImageData)
        
        // Save image
        self.postData!.setObject(photoFile!, forKey: myChatsGraphicFileKey)
        self.postData!.setObject(thumbnailFile!, forKey: myChatsThumbnailKey)
        
        let alert = SCLAlertView()
        alert.showCloseButton = false
        alert.addButton("OK", action: { () -> Void in
            self.navigationController?.popViewControllerAnimated(true)
        })
        
        do{
            self.fileUploadBackgroundTaskId = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler {
                UIApplication.sharedApplication().endBackgroundTask(self.fileUploadBackgroundTaskId)
            }
            try self.postData!.save()
            UIApplication.sharedApplication().endBackgroundTask(self.fileUploadBackgroundTaskId)
            NSNotificationCenter.defaultCenter().postNotificationName("TalkView.didFinishEditingPhoto", object: postData)
            alert.showSuccess("成功", subTitle:"投稿が完了しました！", closeButtonTitle: "OK")
        }catch{
            MBProgressHUD.hideHUDForView(self.navigationController!.view, animated: true)
            UIApplication.sharedApplication().endBackgroundTask(self.fileUploadBackgroundTaskId)
            alert.showError("エラー", subTitle:"投稿に失敗しました。ネットワーク接続を確認してください。", closeButtonTitle:"OK")
        }
        
    }
    
}