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
    
    @IBOutlet weak var mybutton1: UIButton!
    @IBOutlet weak var mybutton: UIButton!
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
            self.mybutton.frame = CGRectMake(0,0,200,50)
            self.mybutton1.frame = CGRectMake(0, 0, 200, 50)
            self.mybutton.backgroundColor = UIColor.greenColor()
            self.mybutton1.backgroundColor = UIColor.redColor()
            self.mybutton.tintColor = UIColor.whiteColor()
            self.mybutton1.tintColor = UIColor.whiteColor()
            self.mybutton.layer.masksToBounds = true
            self.mybutton1.layer.masksToBounds = true
            self.mybutton.layer.cornerRadius = 10.0
            self.mybutton1.layer.cornerRadius = 10.0
            self.mybutton.setTitle("お絵描き", forState: .Normal)
            self.mybutton1.setTitle("撮り直し", forState: .Normal)
            self.mybutton.layer.position = CGPoint(x: self.view.bounds.width/4,y: self.view.bounds.height - 50)
            self.mybutton1.layer.position = CGPoint(x: self.view.bounds.width*3/4,y: self.view.bounds.height - 50)
            self.view.addSubview(self.mybutton)
            self.view.addSubview(self.mybutton1)
            
            self.mybutton1.addTarget(self, action: Selector("viewDidLoad"), forControlEvents: .TouchUpInside)
            
            
            // アルバムに追加.
            // UIImageWriteToSavedPhotosAlbum(myImage, self, nil, nil)
            
            func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
                if(segue.identifier == "mySegue") {
                    let vc = segue.destinationViewController as! paint
                    vc.pictureImage = myImageData
                }
            }

            
        })
    }
    

    
}