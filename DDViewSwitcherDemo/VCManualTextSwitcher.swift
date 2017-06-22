//
//  VCManualTextSwitcher.swift
//  DDViewSwitcher
//
//  Created by DingMac on 2017. 6. 21..
//  Copyright © 2017년 Dingding. All rights reserved.
//

import UIKit

class VCManualTextSwitcher: UIViewController {
    @IBOutlet weak var viewSwitcher: UIView!
    @IBOutlet weak var btNext: UIButton!
    
    //Data to be scrolled
    var arrData = [String]()
    
    var textSwitcher: DDTextSwitcher!
    
    let myColor: UIColor = UIColor(red: 255/255, green: 155/255, blue: 192/255, alpha: 0.3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Dummy data
        for index in 0...5 {
            arrData.append("Item : \(index)")
        }
        
        initTextSwitcher()
        textSwitcher.start()
    }
    
    func initTextSwitcher() {
        textSwitcher = DDTextSwitcher(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.viewSwitcher.frame.height), data: arrData, scrollDirection: .vertical)
        viewSwitcher.addSubview(textSwitcher)
        
        //Below code in this method is optional.
        textSwitcher.backgroundColor = myColor //default : clear
        textSwitcher.setTextSize(size: 35.0) //default : 20.0
        textSwitcher.setTextColor(color: UIColor.black) //default : black
        textSwitcher.setTextAlignment(align: .center) //default : center
        textSwitcher.setNumberOfLines(numberOfLines: 1)//default : 0 (can multiline)
        textSwitcher.delay = 1 //default : 1
        textSwitcher.duration = 1 //default : 1
        //************************ Difference ******************
        textSwitcher.isAutoScroll = false //default : true
        //******************************************************
        textSwitcher.isInfiniteScrolling = true //default : true
        
        //Set action when DDTextSwitcher is tapped
        textSwitcher.tapAction = {
            print("DDTextSwitcher is Tapped ! : \(self.textSwitcher.currentText)")
        }
    }
    
    @IBAction func clickNext(_ sender: UIButton) {
        //Scroll to next text
        textSwitcher.next()
    }
}
