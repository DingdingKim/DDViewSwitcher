//
//  DDViewSwitcher.swift
//  DDViewSwitcher
//
//  Created by DingMac on 2017. 6. 15..
//  Copyright © 2017년 Dingding. All rights reserved.
//

import UIKit

open class DDViewSwitcher: UIView {
    
    private var viewCenter = UILabel()
    private var viewNext = UILabel()

    open var isScrolling = false
    open var isAutoScroll = true
    open var isInfiniteScrolling = true
    
    open var arrData = [UIView]()
    
    //Index of current data
    private var indexSwitcher: Int = 0
    
    //Default value of animation
    open var duration = 1.0
    open var delay = 1.0

    open var scrollDirection: ScrollDirection = .vertical
    
    public enum ScrollDirection: String {
        case horizontral = "horizontral"
        case vertical = "vertical"
    }
    
    private var pointVerticalOverTop: CGPoint!
    private var pointVerticalOverBottom: CGPoint!
    private var pointHorizontalOverLeft: CGPoint!
    private var pointHorizontalOverRight: CGPoint!
    
    //Center label point
    private var pointNormal: CGPoint!
    
    //Action when view is tapped
    open var tapAction: ((Void) -> Void)?
    open var finishScrollAction: ((Void) -> Void)?
    open var didChangeItemAction: ((Void) -> Void)?
    
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
    open func initSwitcher(){
        self.removeFromSuperview()
        
        pointVerticalOverTop = CGPoint(x: 0, y: -self.frame.height)
        pointVerticalOverBottom = CGPoint(x: 0, y: self.frame.height)
        pointHorizontalOverLeft = CGPoint(x: -self.frame.width, y: 0)
        pointHorizontalOverRight = CGPoint(x: self.frame.width, y: 0)
        pointNormal = CGPoint(x: 0, y: 0)
        
        clipsToBounds = true
        
        isScrolling = false
        indexSwitcher = 0
        
        backgroundColor = UIColor.clear
        
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
    open func stop(){
        if(isAutoScroll){
            isScrolling = false
        }
        else {
            debugPrint("DDViewSwitcher >> You can't call stop() method. 'isAutoScroll' value is false")
        }
    }
    
    //Scroll start
    open func start(){
        if(isAutoScroll){
            isScrolling = true
            updateSwitcherAnimation()
        }
        else {
            debugPrint("DDViewSwitcher >> You can't call resume() method. 'isAutoScroll' value is false")
        }
    }
    
    //Scroll reset
    open func reset(){
        indexSwitcher = 0
        self.viewCenter.frame.origin = pointNormal
        self.viewNext.frame.origin = (self.scrollDirection == .vertical) ? self.pointVerticalOverBottom : self.pointHorizontalOverRight
        
        self.viewCenter.addSubview(arrData[indexSwitcher])
        indexSwitcher += 1
        self.viewNext.addSubview(arrData[indexSwitcher])
    }

    //Animate to next text
    open func next(){
        if(isAutoScroll){
            debugPrint("DDViewSwitcher >> You can't call next() method. 'isAutoScroll' value is true")
        }
        else {
            updateSwitcherAnimation()
        }
    }
    
    //****************************
    open func updateSwitcherAnimation() {
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
                    
                    debugPrint("DDViewSwitcher >> Scrolling is end. 'isInfiniteScrolling' value is false")
                    
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
            
            //call handler
            self.didChangeItem()

            //This case is stop() is called.
            //if without check 'finished' values updateSwitcherAnimation will execute repeatedly after view controller is dismiss.
            if(finished && self.isScrolling){
                self.updateSwitcherAnimation()
            }
        })
    }
    
    //Tap action handler
    open func didTap(sender: UITapGestureRecognizer) {
        guard let action = self.tapAction else { return /*didn't set closure*/}
        action()
    }
    
    //scroll finish(Only isInfiniteScrolling is false) action handler
    open func finishScroll() {
        guard let action = self.finishScrollAction else { return /*didn't set closure*/}
        action()
    }
    
    //scroll finish(Only isInfiniteScrolling is false) action handler
    open func didChangeItem() {
        guard let action = self.didChangeItemAction else { return /*didn't set closure*/}
        action()
    }
}
