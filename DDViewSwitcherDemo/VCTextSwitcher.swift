//
//  VCTextSwitcher.swift
//  DDViewSwitcher
//
//  Created by DingMac on 2017. 6. 22..
//  Copyright © 2017년 DingdingKim. All rights reserved.
//

import UIKit

class VCTextSwitcher: UIViewController {
    @IBOutlet weak var viewForSwitcherInfinite: UIView!
    @IBOutlet weak var viewForSwitcherOnce: UIView!
    @IBOutlet weak var btStartOrStopInfinite: UIButton!
    @IBOutlet weak var btStartOrStopOnce: UIButton!
    
    //Data to be scrolled
    var arrData = [String]()
    
    var textSwitcherInfinite: DDTextSwitcher!
    var textSwitcherOnce: DDTextSwitcher!
    
    let myColor: UIColor = UIColor(red: 255/255, green: 155/255, blue: 192/255, alpha: 0.3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Dummy data
        for index in 0...5 {
            arrData.append("Item : \(index)")
        }
        
        initTextSwitcherInfinite()
        initTextSwitcherOnce()
        
        textSwitcherInfinite.start()
        textSwitcherOnce.start()
    }
    
    //Scroll Infinite switcher
    func initTextSwitcherInfinite() {
        textSwitcherInfinite = DDTextSwitcher(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.viewForSwitcherInfinite.frame.height), data: arrData, scrollDirection: .vertical)
        viewForSwitcherInfinite.addSubview(textSwitcherInfinite)
        
        //Below code in this method is optional.
        textSwitcherInfinite.backgroundColor = myColor //default : clear
        textSwitcherInfinite.setTextSize(size: 35.0) //default : 20.0
        textSwitcherInfinite.setTextColor(color: UIColor.black) //default : black
        textSwitcherInfinite.setTextAlignment(align: .center) //default : center
        textSwitcherInfinite.setNumberOfLines(numberOfLines: 1)//default : 0 (can multiline)
        textSwitcherInfinite.delay = 1 //default : 1
        textSwitcherInfinite.duration = 1 //default : 1
        textSwitcherInfinite.isAutoScroll = true //default : true
        textSwitcherInfinite.isInfiniteScrolling = true //default : true
        
        //Set action when DDTextSwitcher is tapped
        textSwitcherInfinite.tapAction = {
            print("Infinite DDTextSwitcher is Tapped ! : \(self.textSwitcherInfinite.currentText)")
        }
    }
    
    //Scroll Once switcher
    func initTextSwitcherOnce() {
        textSwitcherOnce = DDTextSwitcher(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.viewForSwitcherOnce.frame.height), data: arrData, scrollDirection: .horizontal)
        viewForSwitcherOnce.addSubview(textSwitcherOnce)
        
        //Below code in this method is optional.
        textSwitcherOnce.backgroundColor = myColor //default : clear
        textSwitcherOnce.setTextSize(size: 35.0) //default : 20.0
        textSwitcherOnce.setTextColor(color: UIColor.black) //default : black
        textSwitcherOnce.setTextAlignment(align: .center) //default : center
        textSwitcherOnce.setNumberOfLines(numberOfLines: 1)//default : 0 (can multiline)
        textSwitcherOnce.delay = 1 //default : 1
        textSwitcherOnce.duration = 1 //default : 1
        textSwitcherOnce.isAutoScroll = true //default : true
        //*********************** Diffrence *************************
        textSwitcherOnce.isInfiniteScrolling = false //default : true
        //***********************************************************
        
        //Set action when DDTextSwitcher is tapped
        textSwitcherOnce.tapAction = {
            print("Once DDTextSwitcher is Tapped ! : \(self.textSwitcherOnce.currentText)")
        }
        
        //*********************** Difference ************************
        //Set action when scrolling is finish. This work only 'isInfiniteScrolling' is false
        textSwitcherOnce.finishScrollAction = {
            self.btStartOrStopOnce.setTitle("Restart", for: .normal)
        }
        //***********************************************************
    }
    
    @IBAction func clickStartOrStop(_ sender: UIButton) {
        //Infinite
        if(sender == btStartOrStopInfinite) {
            if(textSwitcherInfinite.isScrolling) {
                btStartOrStopInfinite.setTitle("Start", for: .normal)
                textSwitcherInfinite.stop()
            }
            else{
                btStartOrStopInfinite.setTitle("Stop", for: .normal)
                textSwitcherInfinite.start()
            }
        }
        //Once
        else if(sender == btStartOrStopOnce) {
            if(textSwitcherOnce.isScrolling) {
                btStartOrStopOnce.setTitle("Start", for: .normal)
                textSwitcherOnce.stop()
            }
            else{
                if(self.btStartOrStopOnce.titleLabel?.text == "Restart"){
                    //Reset scroll state.
                    self.textSwitcherOnce.reset()
                }
                
                btStartOrStopOnce.setTitle("Stop", for: .normal)
                textSwitcherOnce.start()
            }
        }
    }
}
