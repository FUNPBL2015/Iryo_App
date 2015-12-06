//
//  album.swift
//  Iryo_App
//
//  Created by member on 2015/10/21.
//  Copyright © 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit
import Parse

class album: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextMonthButton: UIButton!
    @IBOutlet weak var prevMonthButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var currentYear: Int = 0
    var currentMonth: Int = 0
    var nowYear: Int = 0
    var nowMonth: Int = 0
    var dates:[String] = []
    let dateFormatter:NSDateFormatter = NSDateFormatter();
    
    var picture:[AnyObject] = []
    var pictures:[AnyObject] = []
    var mealPicture:[AnyObject] = []
    var familyPicture:[AnyObject] = []
    var hobbyPicture:[AnyObject] = []
    var otherPicture:[AnyObject] = []
    var timePicture:[AnyObject] = []
    var tagNumber: Int = 0
    var usernames:[AnyObject]!
    
    var number: Int?
    
    var slidePicture:[NSData] = []
    var slideNumber = 0
    var imageView: UIImageView!
    var timer: NSTimer!
    var stopButton: UIButton!
    
    var timeButton = UIBarButtonItem()
    var mealButton = UIBarButtonItem()
    var familyButton = UIBarButtonItem()
    var hobbyButton = UIBarButtonItem()
    var otherButton = UIBarButtonItem()
    let btn: UIButton = UIButton(type: .System)
    let btn2: UIButton = UIButton(type: .System)
    let btn3: UIButton = UIButton(type: .System)
    let btn4: UIButton = UIButton(type: .System)
    let btn5: UIButton = UIButton(type: .System)
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController!.toolbar.barStyle = self.navigationController!.navigationBar.barStyle
//        self.navigationController!.toolbar.tintColor = self.navigationController!.navigationBar.tintColor
        self.navigationController?.setToolbarHidden(false, animated: true)
        self.navigationController?.toolbar.frame = CGRectMake(0, 924, 768, 100)
        
        navigationItem.title = "みんなのアルバム"
        
        timeLabel.textAlignment = NSTextAlignment.Center
        timeLabel.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height-924)
        nextMonthButton.layer.position = CGPoint(x: self.view.bounds.width/4, y:self.view.bounds.height-924)
        prevMonthButton.layer.position = CGPoint(x: self.view.bounds.width*3/4, y:self.view.bounds.height-824)
        
        let now = NSDate()
        
        var dateString:String = ""
        self.dateFormatter.locale = NSLocale(localeIdentifier: "ja")
        self.dateFormatter.dateFormat = "yyyy/MM";
        dateString = self.dateFormatter.stringFromDate(now);
        dates = dateString.componentsSeparatedByString("/")
        nowYear = Int(dates[0])!
        nowMonth = Int(dates[1])!

        dateShow()
        loadData()
        
        btn.addTarget(self, action: "selectTag:", forControlEvents: UIControlEvents.TouchUpInside)
        btn.frame = CGRectMake(0, 0, 135, 50)
        btn.setTitle("時間", forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(26)
        btn.tag = 4
        btn.layer.borderWidth = 1
        
        btn2.addTarget(self, action: "selectTag:", forControlEvents: UIControlEvents.TouchUpInside)
        btn2.frame = CGRectMake(0, 0, 135, 50)
        btn2.setTitle("食事", forState: UIControlState.Normal)
        btn2.titleLabel?.font = UIFont.systemFontOfSize(26)
        btn2.tag = 0
        
        btn3.addTarget(self, action: "selectTag:", forControlEvents: UIControlEvents.TouchUpInside)
        btn3.frame = CGRectMake(0, 0, 135, 50)
        btn3.setTitle("家族", forState: UIControlState.Normal)
        btn3.titleLabel?.font = UIFont.systemFontOfSize(26)
        btn3.tag = 1

        btn4.addTarget(self, action: "selectTag:", forControlEvents: UIControlEvents.TouchUpInside)
        btn4.frame = CGRectMake(0, 0, 135, 50)
        btn4.setTitle("趣味", forState: UIControlState.Normal)
        btn4.titleLabel?.font = UIFont.systemFontOfSize(26)
        btn4.tag = 2

        btn5.addTarget(self, action: "selectTag:", forControlEvents: UIControlEvents.TouchUpInside)
        btn5.frame = CGRectMake(0, 0, 135, 50)
        btn5.setTitle("その他", forState: UIControlState.Normal)
        btn5.titleLabel?.font = UIFont.systemFontOfSize(26)
        btn5.tag = 3
        
        timeButton = UIBarButtonItem(customView: btn)
        mealButton = UIBarButtonItem(customView: btn2)
        familyButton = UIBarButtonItem(customView: btn3)
        hobbyButton = UIBarButtonItem(customView: btn4)
        otherButton = UIBarButtonItem(customView: btn5)
        
        self.toolbarItems = [timeButton, mealButton, familyButton, hobbyButton, otherButton]

        let myBarButton = UIBarButtonItem(title: "スライドショー", style: .Plain, target: self, action: "slide:")
        self.navigationItem.setRightBarButtonItem(myBarButton, animated: true)
    }
    
    /* 日付について */
    func dateShow(){
        currentYear  = Int(dates[0])!
        currentMonth = Int(dates[1])!
        timeLabel.text = (String(currentYear) + "年" + String(currentMonth) + "月")
        
        //翌月
        let next = self.getNextYearAndMonth()
        let nextYear = String(next.year)
        let nextMonth = String(next.month)
        if(Int(nextYear) >  nowYear || Int(nextMonth) > nowMonth){
            nextMonthButton.hidden = true
        }else{
            nextMonthButton.hidden = false
        }
        let nextDate: String = (nextYear + "年" + nextMonth + "月")
        self.nextMonthButton.setTitle(nextDate, forState: .Normal)
        self.nextMonthButton.addTarget(self, action: Selector("showNextView"), forControlEvents: .TouchUpInside)
        
        //前月
        let prev = self.getPrevYearAndMonth()
        let prevYear = String(prev.year)
        let prevMonth = String(prev.month)
        let prevDate: String = (prevYear + "年" + prevMonth + "月")
        self.prevMonthButton.setTitle(prevDate, forState: .Normal)
        
        self.prevMonthButton.addTarget(self, action: Selector("showPrevView"), forControlEvents: .TouchUpInside)
    }
    
    func showNextView (){
        currentMonth++;
        if( currentMonth > 12 ){
            currentMonth = 1;
            currentYear++;
        }
        dates[0] = String(currentYear)
        dates[1] = String(currentMonth)
        dateShow()
        dateSet()
    }
    
    func showPrevView () {
        currentMonth--
        if( currentMonth == 0 ){
            currentMonth = 12
            currentYear--
        }
        dates[0] = String(currentYear)
        dates[1] = String(currentMonth)
        dateShow()
        dateSet()
    }
    
    func getNextYearAndMonth () -> (year:Int,month:Int){
        var next_year:Int = currentYear
        var next_month:Int = currentMonth + 1
        if next_month > 12 {
            next_month=1
            next_year++
        }
        return (next_year,next_month)
    }
    func getPrevYearAndMonth () -> (year:Int,month:Int){
        var prev_year:Int = currentYear
        var prev_month:Int = currentMonth - 1
        if prev_month == 0 {
            prev_month = 12
            prev_year--
        }
        return (prev_year,prev_month)
    }
    
/* cellについて　*/
    func loadData()  {
        var i: Int = 0
        var allPicture:[AnyObject] = []
        let query: PFQuery = PFQuery(className: myChatsClassKey)
        query.orderByAscending("createdAt")
        query.includeKey(myChatsUserKey)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if (error != nil){
                // エラー処理
                return
            }
            for row:PFObject in objects! {
                allPicture.append(row)
                i++
            }
            for(var n = 0 ; n < allPicture.count ; n++){
                if(allPicture[n].objectForKey("user")?.objectForKey("username") != nil){
                    let check: String? = allPicture[n].objectForKey("user")?.objectForKey("username") as! String?
                    for(var m = 0 ; m < self.usernames.count ; m++){
                        if(check == self.usernames[m] as? String){
                            self.picture.append(allPicture[n])
                        }
                    }
                }
            }
            self.dateSet()
        }
    }
    
    func dateSet() {
        var pictureYear: Int = 0
        var pictureMonth: Int = 0
        var pictureDateString:String = ""
        var pictureDates:[String] = []
        pictures = []
        mealPicture = []
        familyPicture = []
        hobbyPicture = []
        otherPicture = []
        timePicture = []
        var k: [NSDate] = []
        
        for (var i = 0; i < picture.count; i++) {
            if let string = picture[i].createdAt as NSDate! {
                k.append(string)
                        
                pictureDateString = self.dateFormatter.stringFromDate(k[i]);
                pictureDates = pictureDateString.componentsSeparatedByString("/")
                pictureYear  = Int(pictureDates[0])!
                pictureMonth = Int(pictureDates[1])!
                        
                if (pictureMonth == self.currentMonth && pictureYear == self.currentYear){
                    
                    let imageTag: Int = (picture[i].objectForKey("tag") as? Int)!
                    switch imageTag {
                    case 0:
                        mealPicture.append(picture[i])
                    case 1:
                        familyPicture.append(picture[i])
                    case 2:
                        hobbyPicture.append(picture[i])
                    case 3:
                        otherPicture.append(picture[i])
                    case -1:
                        break
                    default:
                        break
                    }
                    pictures.append(picture[i])
                    timePicture.append(picture[i])
                    tagKeep(tagNumber)
                }
            }
        }
        slidePicture = []
        self.collectionView.reloadData()
    }
    
    func selectTag(sender: UIButton) {
        switch(sender.tag) {
        case 0:
            pictures = mealPicture
            tagNumber = 1
            btn.layer.borderWidth = 0
            btn2.layer.borderWidth = 1
            btn3.layer.borderWidth = 0
            btn4.layer.borderWidth = 0
            btn5.layer.borderWidth = 0
        case 1:
            pictures = familyPicture
            tagNumber = 2
            btn.layer.borderWidth = 0
            btn2.layer.borderWidth = 0
            btn3.layer.borderWidth = 1
            btn4.layer.borderWidth = 0
            btn5.layer.borderWidth = 0
        case 2:
            pictures = hobbyPicture
            tagNumber = 3
            btn.layer.borderWidth = 0
            btn2.layer.borderWidth = 0
            btn3.layer.borderWidth = 0
            btn4.layer.borderWidth = 1
            btn5.layer.borderWidth = 0
        case 3:
            pictures = otherPicture
            tagNumber = 4
            btn.layer.borderWidth = 0
            btn2.layer.borderWidth = 0
            btn3.layer.borderWidth = 0
            btn4.layer.borderWidth = 0
            btn5.layer.borderWidth = 1
        case 4:
            pictures = timePicture
            tagNumber = 5
            btn.layer.borderWidth = 1
            btn2.layer.borderWidth = 0
            btn3.layer.borderWidth = 0
            btn4.layer.borderWidth = 0
            btn5.layer.borderWidth = 0
        default:
            break
        }
        slidePicture = []
        collectionView.reloadData()
    }
    
    func tagKeep(number: Int) {
        switch(number) {
        case 0:
            break
        case 1:
            pictures = mealPicture
        case 2:
            pictures = familyPicture
        case 3:
            pictures = hobbyPicture
        case 4:
            pictures = otherPicture
        case 5:
            pictures = timePicture
        default:
            break
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:CustomCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomCell

        let imageFile: PFFile? = pictures[indexPath.row].objectForKey("graphicFile") as! PFFile?
        imageFile?.getDataInBackgroundWithBlock({ (imageData, error) -> Void in
            if(error == nil) {
                cell.imgSample.image = UIImage(data: imageData!)!
                self.slidePicture.append(imageData!)
                }
        })
        return cell
    }
    
    // Cell が選択された場合
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        number = indexPath.row
        if number != nil {
            performSegueWithIdentifier("Segues",sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "Segues") {
            let VC = segue.destinationViewController as! picture2
            VC.numbers = number
            VC.pictures = pictures
            VC.navigationItem.title = ""
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: CGFloat = view.frame.width / 4-3
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }
    
/* スライドショーについて */
    func slide(sender: UIButton) {
        if(slidePicture.count > 0){
            collectionView.hidden = true
            nextMonthButton.hidden = true
            prevMonthButton.hidden = true
            timeLabel.hidden = true
        
            let image:UIImage! = UIImage(data: slidePicture[0])
            imageView = UIImageView(frame: CGRect(x: 0, y: 75, width: self.view.frame.width, height: self.view.frame.width))
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            imageView.image = image;
            self.view.addSubview(imageView)
        
            stopButton = UIButton(frame: CGRectMake(0, 0, 200, 60))
            stopButton.backgroundColor = UIColor.redColor()
            stopButton.layer.masksToBounds = true
            stopButton.layer.cornerRadius = 10.0
            stopButton.setTitle("停止", forState: UIControlState.Normal)
            stopButton.titleLabel?.font = UIFont.systemFontOfSize(30)
            stopButton.addTarget(self, action: "slideStop:", forControlEvents: .TouchUpInside)
            let stop = UIBarButtonItem(customView: stopButton)
            let Button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
            self.toolbarItems = [Button, stop, Button]
        
            timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("nextPage"), userInfo: nil, repeats: true)
        }
    }
    
    func nextPage (){
        slideNumber++
        if(slideNumber < slidePicture.count){
            imageView.image = UIImage(data: slidePicture[slideNumber])
        }else {
            imageView.removeFromSuperview()
            stopButton.removeFromSuperview()
            collectionView.hidden = false
            nextMonthButton.hidden = false
            prevMonthButton.hidden = false
            timeLabel.hidden = false
            dateShow()
            dateSet()
            timer.invalidate()
            slideNumber = 0
            self.toolbarItems = [timeButton, mealButton, familyButton, hobbyButton, otherButton]
        }
    }
    
    func slideStop(sender: UIButton){
        imageView.removeFromSuperview()
        stopButton.removeFromSuperview()
        collectionView.hidden = false
        nextMonthButton.hidden = false
        prevMonthButton.hidden = false
        timeLabel.hidden = false
        dateShow()
        dateSet()
        timer.invalidate()
        slideNumber = 0
        self.toolbarItems = [timeButton, mealButton, familyButton, hobbyButton, otherButton]
    }

}
