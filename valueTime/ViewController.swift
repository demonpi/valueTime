//
//  ViewController.swift
//  valueTime
//
//  Created by 皮少 on 16/4/4.
//  Copyright © 2016年 皮少. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dispatch_async(dispatch_get_main_queue(), {
            self.timePicker.countDownDuration = NSTimeInterval(self.leftTime)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var isStart:Bool = false
    var leftTime = 1500
    var timer:NSTimer!

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    //控制台打印剩余秒数
    @IBAction func timeValue(sender: UIDatePicker) {
        leftTime = Int(sender.countDownDuration)
        print(String(leftTime)+"秒")
        timeLabel.text = String(leftTime/60) + "分0秒"
    }
    
    //测试按键，在删除时要记得删除关联
    @IBAction func state(sender: UIButton) {
        let button = sender.currentTitle!
        print("\(button)")
    }
    
    //点击开始按键的响应函数
    @IBAction func startClicked(sender: UIButton) {
        isStart = true
        timePicker.enabled = false
        startButton.enabled = false
        
        timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1), target: self, selector: #selector(ViewController.tickDown), userInfo: nil, repeats: true)
    }
    
    //点击停止按键的响应函数
    @IBAction func stopClicked(sender: UIButton) {
        initTickDown()
    }
    
    //倒计时每秒调用函数
    func tickDown()
    {
        leftTime -= 1
        print(leftTime)
        self.timePicker.countDownDuration = NSTimeInterval(leftTime)
        
        let tempMin = leftTime / 60
        let tempSec = leftTime % 60
        
        //label显示剩余时间
        self.timeLabel.text = String(tempMin) + "分" + String(tempSec) + "秒"
        
        if leftTime <= 0{
            //提示框
            let alertController = UIAlertController(title: "通知", message: "惜时如金！", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "知道了", style: UIAlertActionStyle.Default, handler: nil)
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            
            //声音＋震动
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            //建立的SystemSoundID对象
            var soundID:SystemSoundID = 0
            //获取声音地址
            let path = NSBundle.mainBundle().pathForResource("msg", ofType: "wav")
            //地址转换
            let baseURL = NSURL(fileURLWithPath: path!)
            //赋值
            AudioServicesCreateSystemSoundID(baseURL, &soundID)
            //播放声音
            AudioServicesPlaySystemSound(soundID)
            
            initTickDown()
        }
    }
    
    func initTickDown(){
        //重置
        if timer != nil {
            timer.invalidate()
        }
        isStart = false
        timePicker.enabled = true
        startButton.enabled = true
        
        leftTime = Int(timePicker.countDownDuration)
        timeLabel.text = String(leftTime/60) + "分0秒"
    }
    
    func reduceLeftTime(t:Int){
        leftTime -= t
    }

}

