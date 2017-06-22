//
//  VCViewSwitcher.swift
//  DDViewSwitcher
//
//  Created by DingMac on 2017. 6. 22..
//  Copyright © 2017년 DingdingKim. All rights reserved.
//

import UIKit

class VCViewSwitcher: UIViewController {
    @IBOutlet weak var viewForSwitcher: UIView!
    @IBOutlet weak var btStartOrStop: UIButton!
    
    //Data to be scrolled
    var arrData = [UIView]()
    
    var switcher: DDViewSwitcher!
    
    let myColor: UIColor = UIColor(red: 255/255, green: 155/255, blue: 192/255, alpha: 0.3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeCustomView()
        initSwitcher()
        switcher.start()
    }
    
    //Make your own view to be scrolled
    func makeCustomView() {
        //For background color
        let arrColor = [UIColor.blue, UIColor.purple, UIColor.red, UIColor.green, UIColor.brown]
        
        //Images download at https://material.io/icons
        let arrImageLeft = ["ic_face_white_48pt", "ic_favorite_white_48pt", "ic_cake_white_48pt", "ic_mood_white_48pt", "ic_star_white_48pt"]
        let arrImageRight = ["ic_favorite_white_48pt", "ic_star_white_48pt", "ic_face_white_48pt", "ic_cake_white_48pt", "ic_mood_white_48pt"]
        
        //Dummy view
        for index in 0...4 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.viewForSwitcher.frame.height))
            view.backgroundColor = arrColor[index]
            
            let lbInView = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 50))
            lbInView.text = "Item : \(index)"
            lbInView.textColor = UIColor.white
            lbInView.textAlignment = .center
            
            let imgInViewLeft = UIImageView(frame: CGRect(x: 0, y: 50, width: self.view.bounds.width/2, height: self.viewForSwitcher.frame.height-50))
            let imgInViewRight = UIImageView(frame: CGRect(x: self.view.bounds.width/2, y: 50, width: self.view.bounds.width/2, height: self.viewForSwitcher.frame.height-50))
            imgInViewLeft.image = UIImage(named: arrImageLeft[index])
            imgInViewRight.image = UIImage(named: arrImageRight[index])
            
            view.addSubview(lbInView)
            view.addSubview(imgInViewLeft)
            view.addSubview(imgInViewRight)
            
            arrData.append(view)
        }
    }
    
    func initSwitcher() {
        switcher = DDViewSwitcher(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.viewForSwitcher.frame.height), data: arrData, scrollDirection: .vertical)
        viewForSwitcher.addSubview(switcher)
        
        //Below code in this method is optional.
        switcher.backgroundColor = myColor //default : clear
        switcher.delay = 1 //default : 1
        switcher.duration = 1 //default : 1
        switcher.isAutoScroll = true //default : true
        switcher.isInfiniteScrolling = true //default : true
        
        //Set action when DDTextSwitcher is tapped
        switcher.tapAction = {
            print("DDViewSwitcher is Tapped !")
        }
        
        //Set action when scrolling is finish. This work only 'isInfiniteScrolling' is false
        switcher.finishScrollAction = {
            self.btStartOrStop.setTitle("Restart", for: .normal)
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
