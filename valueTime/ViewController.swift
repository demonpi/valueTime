//
//  ViewController.swift
//  valueTime
//
//  Created by 皮少 on 16/4/4.
//  Copyright © 2016年 皮少. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var isStart:Bool = false
    var leftTime = 1500
    var timer:NSTimer!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioPlayer:AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dispatch_async(dispatch_get_main_queue(), {
            self.timePicker.countDownDuration = NSTimeInterval(self.leftTime)
        })
        let soundFilePath = NSBundle.mainBundle().pathForResource("RainyMood",ofType: "mp3")
        let soundFileURL = NSURL(fileURLWithPath: soundFilePath!)
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: soundFileURL)
        }
        catch {
            print(error)
        }
        
        initTickDown()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
        //播放音频
        audioPlayer?.currentTime = 0
        audioPlayer!.play()
        audioPlayer?.numberOfLoops = -1
        
        isStart = true
        timeLabel.hidden = false
        timePicker.hidden = true
        startButton.hidden = true
        stopButton.hidden = false
        
        timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1), target: self, selector: #selector(ViewController.tickDown), userInfo: nil, repeats: true)
    }
    
    //点击停止按键的响应函数
    @IBAction func stopClicked(sender: UIButton) {
        audioPlayer!.stop()
        initTickDown()
    }
    
    //倒计时每秒调用函数
    func tickDown()
    {
        leftTime -= 1
        print(leftTime)
        
        let tempMin = leftTime / 60
        let tempSec = leftTime % 60
        
        //label显示剩余时间
        self.timeLabel.text = String(tempMin) + "分" + String(tempSec) + "秒"
        
        if leftTime <= 0{
            audioPlayer?.stop()
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

        leftTime = 1500
        timePicker.countDownDuration = NSTimeInterval(leftTime)
        timePicker.hidden = false
        timeLabel.hidden = true
        startButton.hidden = false
        stopButton.hidden = true
        
        leftTime = Int(timePicker.countDownDuration)
        timeLabel.text = String(leftTime/60) + "分0秒"
    }
    
    func reduceLeftTime(t:Int){
        leftTime -= t
    }

}

