//
//  PostDetailVC.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/11/18.
//  Copyright © 2015年 b1013075. All rights reserved.
//

import UIKit

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
    var image: UIImage?
    let paintView = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("PaintVC") as? PaintVC
    
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
        
        self.paintView!.delegate = self
        self.postData = PFObject(className: myChatsClassKey)
    }
    
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

    func paintDidFinished(modalText: UIImage){
        
        self.image = modalText
        self.postImage.image = modalText
        self.paintView!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didTapOnPaintBtn(sender: AnyObject) {
        self.paintView!.image = self.image
        
        self.presentViewController(paintView!, animated: true, completion: nil)
    }
    
    @IBAction func didTapOnPostBtn(sender: AnyObject) {
        
        self.postData!.setObject(postSegmented.selectedSegmentIndex, forKey: myChatsTagKey)
        
        let resizedImage: UIImage = self.postImage.image!.resizedImageWithContentMode(UIViewContentMode.ScaleAspectFit, bounds: CGSizeMake(560.0, 560.0), interpolationQuality: CGInterpolationQuality.High)
        let thumbnailImage: UIImage = self.postImage.image!.thumbnailImage(256, transparentBorder: 0, cornerRadius: 10, interpolationQuality: CGInterpolationQuality.Medium)
        
        let imageData: NSData = UIImageJPEGRepresentation(resizedImage, 0.8)!
        let thumbnailImageData: NSData = UIImagePNGRepresentation(thumbnailImage)!
        
        let photoFile = PFFile(data: imageData)
        let thumbnailFile = PFFile(data: thumbnailImageData)
        
        // Save image
        self.postData!.setObject(photoFile!, forKey: myChatsGraphicFileKey)
        self.postData!.setObject(thumbnailFile!, forKey: myChatsThumbnailKey)
        
        let alert = SCLAlertView()
        alert.showCloseButton = false
        alert.addButton("OK", action: { () -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        })
        do{
            try self.postData!.save()
            NSNotificationCenter.defaultCenter().postNotificationName("TalkView.didFinishEditingPhoto", object: postData)
            alert.showSuccess("Success", subTitle:"Success")
        }catch{
            alert.showError("Warning", subTitle:"Couldn't post your photo", closeButtonTitle:"OK")
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
}