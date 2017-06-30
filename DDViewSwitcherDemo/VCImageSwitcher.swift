//
//  VCImageSwitcher.swift
//  DDViewSwitcher
//
//  Created by DingMac on 2017. 6. 22..
//  Copyright © 2017년 DingdingKim. All rights reserved.
//

import UIKit

class VCImageSwitcher: UIViewController {
    @IBOutlet weak var viewForSwitcher: UIView!
    @IBOutlet weak var btStartOrStop: UIButton!
    
    //Data to be scrolled (Image names)
    var arrData = [String]()
    
    var switcher: DDImageSwitcher!
    
    let myColor: UIColor = UIColor(red: 255/255, green: 155/255, blue: 192/255, alpha: 0.3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeData()
        
        initSwitcher()
        switcher.start()
    }
    
    func makeData() {
        //Dummy data
        //Images download at https://material.io/icons
        let arrImageNames = ["ic_favorite_white_48pt", "ic_star_white_48pt", "ic_face_white_48pt", "ic_cake_white_48pt", "ic_mood_white_48pt"]
        
        for imageName in arrImageNames {
            arrData.append(imageName)
        }
    }
    
    func initSwitcher() {
        switcher = DDImageSwitcher(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.viewForSwitcher.frame.height), data: arrData, scrollDirection: .vertical)
        viewForSwitcher.addSubview(switcher)
        
        //Below code in this method is optional.
        switcher.backgroundColor = myColor //default : clear
        switcher.setContentMode(contentMode: .scaleAspectFit) //default : scaleToFill
        switcher.delay = 1 //default : 1
        switcher.duration = 1 //default : 1
        switcher.isAutoScroll = true //default : true
        switcher.isInfiniteScrolling = true //default : true
        
        //Set action when DDTextSwitcher is tapped
        switcher.tapAction = {
            print("DDImageSwitcher is Tapped !")
        }
        
        //Set action when scrolling is finish. This work only 'isInfiniteScrolling' is false
        switcher.finishScrollAction = {
            self.btStartOrStop.setTitle("Restart", for: .normal)
        }
        
        //Set action when item is changed(scrolled)
        switcher.didChangeItemAction = {
            print("DDImageSwitcher >> didChangeItemAction !!")
        }
    }
    
    @IBAction func clickStartOrStop(_ sender: Any) {
        if(switcher.isScrolling) {
            btStartOrStop.setTitle("Start", for: .normal)
            switcher.stop()
        }
        else{
            if(self.btStartOrStop.titleLabel?.text == "Restart"){
                self.switcher.reset()
            }

            btStartOrStop.setTitle("Stop", for: .normal)
            switcher.start()
        }
    }
}
