//
//  VCMain.swift
//  DDViewSwitcher
//
//  Created by DingMac on 2017. 6. 22..
//  Copyright © 2017년 DingdingKim. All rights reserved.
//

import UIKit

class VCMain: UIViewController {
    @IBOutlet weak var viewForSwitcher: UIView!
    
    var textSwitcher: DDTextSwitcher!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "DDTextSwitcher"
        
        initTextSwitcher()
    }
    
    //**************************************************
    //  This code is simplest way to make DDTextSwitcher !
    //  You want to change attributes and more detail, look other ViewController in this sample !
    //**************************************************
    func initTextSwitcher() {
        //Data to be scrolled
        var arrData = [String]()
        
        //Make dummy data
        arrData.append("Hello! ✋")
        arrData.append("I'm DDTextSwitcher! 🙌")
        //arrData.append("DD is my nickname Dingding")^^;;;
        arrData.append("I hope this library is useful to you 😊")
        arrData.append("Thank U :D ❤")
        
        //**************************************************
        //  Just two line! That's all. *^____________^*
        
        textSwitcher = DDTextSwitcher(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: viewForSwitcher.frame.height), data: arrData, scrollDirection: .vertical)
        viewForSwitcher.addSubview(textSwitcher)
        
        //**************************************************
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "DDTextSwitcher"
        textSwitcher.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = "Back"
        
        textSwitcher.stop()
    }
}
