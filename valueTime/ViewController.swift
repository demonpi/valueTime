//
//  ViewController.swift
//  valueTime
//
//  Created by 皮少 on 16/4/4.
//  Copyright © 2016年 皮少. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var isStart:Bool = false

    @IBOutlet weak var timeStack: UIStackView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func state(sender: UIButton) {
        let digit = sender.currentTitle!
        timeLabel.text = digit
        print("digit = \(digit)")
    }

}

