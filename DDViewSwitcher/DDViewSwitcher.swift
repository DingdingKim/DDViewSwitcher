//
//  DDViewSwitcher.swift
//  DDTextSwitcher
//
//  Created by DingMac on 2017. 6. 15..
//  Copyright © 2017년 Dingding. All rights reserved.
//

import UIKit

class DDViewSwitcher: UIView {
    
    private var viewCenter = UILabel()
    private var viewNext = UILabel()

    public var isScrolling = false
    public var isAutoScroll = true
    public var isInfiniteScrolling = true
    
    public var arrData = [UIView]()
    
    //Index of current data
    var indexSwitcher: Int = 0
    
    //Default value of animation
    public var duration = 1.0
    public var delay = 1.0

    public var scrollDirection: ScrollDirection = .vertical
    
    public enum ScrollDirection: String {
        case horizontral = "horizontral"
        case vertical = "vertical"
    }

    private var pointVerticalOverTop: CGPoint{
        return CGPoint(x: 0, y: -self.frame.height)
    }
    
    private var pointVerticalOverBottom: CGPoint{
        return CGPoint(x: 0, y: self.frame.height)
    }

    private var pointHorizontalOverLeft: CGPoint{
        return CGPoint(x: -self.frame.width, y: 0)
    }
    
    private var pointHorizontalOverRight: CGPoint{
        return CGPoint(x: self.frame.width, y: 0)
    }
    
    //Center label point
    private var pointNormal: CGPoint{
        return CGPoint(x: 0, y: 0)
    }
    
    //Action when view is tapped
    public var tapAction: ((Void) -> Void)?
    public var finishScrollAction: ((Void) -> Void)?
    
    public init(frame: CGRect, data: [UIView], scrollDirection: ScrollDirection) {
        super.init(frame: frame)
        
        self.arrData = data
        
        self.scrollDirection = scrollDirection
        
        initSwitcher()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        self.addGestureRecognizer(tapGesture)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //Initiallize switcher view. set default values.
    func initSwitcher(){
        self.removeFromSuperview()
        
        clipsToBounds = true
        
        isScrolling = false
        indexSwitcher = 0
        
        backgroundColor = UIColor.yellow
        
        self.viewCenter.frame.size = self.frame.size
        self.viewCenter.frame.origin = pointNormal
        self.addSubview(self.viewCenter)
        
        self.viewNext.frame.size = self.frame.size
        self.viewNext.frame.origin = (self.scrollDirection == .vertical) ? self.pointVerticalOverBottom : self.pointHorizontalOverRight
        self.addSubview(self.viewNext)
        
        self.viewCenter.addSubview(arrData[indexSwitcher])
        indexSwitcher += 1
        self.viewNext.addSubview(arrData[indexSwitcher])
    }
    
    //Scroll stop
    func stop(){
        if(isAutoScroll){
            isScrolling = false
        }
        else {
            debugPrint("DDTextSwitcherLabel >> You can't call stop() method. 'isAutoScroll' value is false")
        }
    }
    
    //Scroll start
    func start(){
        if(isAutoScroll){
            isScrolling = true
            updateSwitcherAnimation()
        }
        else {
            debugPrint("DDTextSwitcherLabel >> You can't call resume() method. 'isAutoScroll' value is false")
        }
    }
    
    //Scroll reset
    func reset(){
        indexSwitcher = 0
        self.viewCenter.frame.origin = pointNormal
        self.viewNext.frame.origin = (self.scrollDirection == .vertical) ? self.pointVerticalOverBottom : self.pointHorizontalOverRight
        
        self.viewCenter.addSubview(arrData[indexSwitcher])
        indexSwitcher += 1
        self.viewNext.addSubview(arrData[indexSwitcher])
    }

    //Animate to next text
    func next(){
        if(isAutoScroll){
            debugPrint("DDTextSwitcherLabel >> You can't call next() method. 'isAutoScroll' value is true")
        }
        else {
            updateSwitcherAnimation()
        }
    }
    
    //****************************
    func updateSwitcherAnimation() {
        UIView.animate(withDuration: duration, delay: delay, options: [], animations: { () -> Void in
            
            self.viewCenter.frame.origin = (self.scrollDirection == .vertical) ? self.pointVerticalOverTop : self.pointHorizontalOverLeft
            self.viewNext.frame.origin = self.pointNormal
            
        }, completion: { (finished: Bool) in
            
            if(self.indexSwitcher >= (self.arrData.count-1)){
                //Index move to zero
                if(self.isInfiniteScrolling) {
                    self.indexSwitcher = 0
                }
                //Scroll is end
                else {
                    self.indexSwitcher = self.indexSwitcher + 1
                    self.isScrolling = false
                    
                    self.finishScroll()
                    
                    debugPrint("DDTextSwitcherLabel >> Scrolling is end. 'isInfiniteScrolling' value is false")
                    
                    return
                }
            }
            else{
                self.indexSwitcher = self.indexSwitcher + 1
            }
            
            if (self.viewCenter.subviews.count > 0) {
                self.viewCenter.subviews[0].removeFromSuperview()
            }
            self.viewCenter.addSubview(self.viewNext.subviews[0])
            
            if (self.viewNext.subviews.count > 0) {
                self.viewNext.subviews[0].removeFromSuperview()
            }
            self.viewNext.addSubview(self.arrData[self.indexSwitcher])
            
            self.viewCenter.frame.origin = self.pointNormal
            self.viewNext.frame.origin = (self.scrollDirection == .vertical) ? self.pointVerticalOverBottom : self.pointHorizontalOverRight

            //This case is stop() is called.
            if(self.isScrolling){
                self.updateSwitcherAnimation()
            }
        })
    }
    
    //Tap action handler
    func didTap(sender: UITapGestureRecognizer) {
        guard let action = self.tapAction else { return /*didn't set closure*/}
        action()
    }
    
    //scroll finish(Only isInfiniteScrolling is false) action handler
    func finishScroll() {
        guard let action = self.finishScrollAction else { return /*didn't set closure*/}
        action()
    }
}
