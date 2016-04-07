//
//  AppDelegate.swift
//  valueTime
//
//  Created by 皮少 on 16/4/4.
//  Copyright © 2016年 皮少. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tempDate: NSDate?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        // 会话类型，这个会覆盖所有其他音频
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            try audioSession.setActive(true)
        }
        catch{
            print(error)
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        //注册后台任务
        application.beginBackgroundTaskWithExpirationHandler(nil)
        //记录进入后台时间
        tempDate = NSDate()
        print(tempDate)
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        let gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let result = gregorian!.components(NSCalendarUnit.Second, fromDate: tempDate!, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))
        
        print(result.second)
        
        //不需要了后台可以运行
//        let tempViewController = self.window?.rootViewController as! ViewController
//        tempViewController.reduceLeftTime(result.second)
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

