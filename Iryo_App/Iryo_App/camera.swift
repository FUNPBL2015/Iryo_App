//
//  camera.swift
//  Iryo_App
//
//  Created by member on 2015/10/22.
//  Copyright © 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit
import AVFoundation

class camera: UIViewController {
    
    
    var mySession : AVCaptureSession!
    var myDevice : AVCaptureDevice!
    var myImageOutput : AVCaptureStillImageOutput!
    
    var myImageView: UIImageView!
    
    internal var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mySession = AVCaptureSession()
        let devices = AVCaptureDevice.devices()
        
        // バックカメラをmyDeviceに格納.
        for device in devices{
            if(device.position == AVCaptureDevicePosition.Back){
                myDevice = device as! AVCaptureDevice
            }
        }
        
        // バックカメラからVideoInputを取得.
        let videoInput: AVCaptureInput!
        do {
            videoInput = try AVCaptureDeviceInput.init(device: myDevice!)
        }catch{
            videoInput = nil
        }
        mySession.addInput(videoInput)
        myImageOutput = AVCaptureStillImageOutput()
        mySession.addOutput(myImageOutput)
        
        // 解像度
        mySession.sessionPreset = AVCaptureSessionPresetPhoto
        
        // 画像を表示するレイヤーを生成
        let myVideoLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer.init(session: mySession) as AVCaptureVideoPreviewLayer
        myVideoLayer.frame = self.view.bounds
        myVideoLayer.videoGravity = AVLayerVideoGravityResize
        
        self.view.layer.addSublayer(myVideoLayer)
        
        // セッション開始.
        mySession.startRunning()
        
        // UIボタンを作成.
        let myButton = UIButton(frame: CGRectMake(0,0,120,50))
        myButton.backgroundColor = UIColor.redColor();
        myButton.layer.masksToBounds = true
        myButton.setTitle("撮影", forState: .Normal)
        myButton.layer.cornerRadius = 20.0
        myButton.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height-50)
        myButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        
        // UIボタンをViewに追加.
        self.view.addSubview(myButton);

    }
    
        
    // ボタンイベント.
    func onClickMyButton(sender: UIButton){
        
        // ビデオ出力に接続.
        let myVideoConnection = myImageOutput.connectionWithMediaType(AVMediaTypeVideo)
        // 接続から画像を取得.
        self.myImageOutput.captureStillImageAsynchronouslyFromConnection(myVideoConnection, completionHandler: { (imageDataBuffer, error) -> Void in
            // 取得したImageのDataBufferをJpegに変換.
            let myImageData : NSData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataBuffer)
            // JpegからUIIMageを作成.
            let myImage : UIImage = UIImage(data: myImageData)!
            // UIImageViewを作成する.
            self.myImageView = UIImageView(frame: CGRectMake(0,0,self.view.frame.size.width*2,self.view.frame.size.height*2))
            // 画像をUIImageViewに設定する.
            self.myImageView.image = myImage
            // 画像の表示する座標を指定する.
            self.myImageView.frame = self.view.bounds
            // UIImageViewをViewに追加する.
            self.view.addSubview(self.myImageView)
            
            self.mySession.stopRunning()
            
            
            // Labelを作成.
            let mybutton: UIButton = UIButton(frame: CGRectMake(0,0,200,50))
            let mybutton1: UIButton = UIButton(frame: CGRectMake(0, 0, 200, 50))
            mybutton.backgroundColor = UIColor.greenColor()
            mybutton1.backgroundColor = UIColor.redColor()
            mybutton.layer.masksToBounds = true
            mybutton1.layer.masksToBounds = true
            mybutton.layer.cornerRadius = 20.0
            mybutton1.layer.cornerRadius = 20.0
            mybutton.setTitle("お絵描き", forState: .Normal)
            mybutton1.setTitle("撮り直し", forState: .Normal)
            mybutton.layer.position = CGPoint(x: self.view.bounds.width/4,y: self.view.bounds.height - 50)
            mybutton1.layer.position = CGPoint(x: self.view.bounds.width*3/4,y: self.view.bounds.height - 50)
            self.view.addSubview(mybutton)
            self.view.addSubview(mybutton1)
            
            mybutton1.addTarget(self, action: Selector("viewDidLoad"), forControlEvents: .TouchUpInside)
            mybutton.addTarget(self, action: "chengeScene:", forControlEvents: .TouchUpInside)
            
            // アルバムに追加.
            // UIImageWriteToSavedPhotosAlbum(myImage, self, nil, nil)
            
        })
    }
    
    internal func chengeScene (sender: UIButton){
        // 遷移するViewを定義する.
        let mypaint: UIViewController = paint()
        
        // アニメーションを設定する.
        mypaint.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        
        // Viewの移動する.
        self.presentViewController(mypaint, animated: true, completion: nil)
        
    }
    
}