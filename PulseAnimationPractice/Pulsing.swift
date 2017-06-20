//
//  Pulsing.swift
//  PulseAnimationPractice
//
//  Created by Allied Infosoft on 20/06/17.
//  Copyright © 2017 Allied Infosoft. All rights reserved.
//

import UIKit


class Pulsing : CALayer {
    
    var animationGroup = CAAnimationGroup()
    
    var initialPulseScale : Float = 0
    var nextPulseAfter : TimeInterval = 0
    var animationDuration : TimeInterval = 1.5
    var radius : CGFloat = 200
    var numberOfPulses : Float = Float.infinity
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // own initializer
    
    init(numberOfPulses : Float = Float.infinity , radius : CGFloat , Position : CGPoint){
        super.init()
        
        self.backgroundColor = UIColor.red.cgColor
        self.contentsScale = UIScreen.main.scale
        self.opacity = 0
        self.numberOfPulses = numberOfPulses
        self.radius = radius
        self.position = Position
        
        self.bounds = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        self.cornerRadius = radius
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            self.setUpAnimationGroup()
            
            DispatchQueue.main.async {
                self.add(self.animationGroup, forKey: "animations")
            }
        }
    }
    
    
    func createScaleAnimation() -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = NSNumber(value: initialPulseScale)
        scaleAnimation.toValue = NSNumber(value: 1)
        scaleAnimation.duration = animationDuration
        return scaleAnimation
    }
    
    
    func createOpacityAnimation() -> CAKeyframeAnimation {
        
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = animationDuration
        opacityAnimation.values = [0.4 , 0.8 , 0]
        opacityAnimation.keyTimes = [0 , 0.2 , 1]
        
        return opacityAnimation
    }
    
    
    
    
    func setUpAnimationGroup() {
        
        self.animationGroup = CAAnimationGroup()
        self.animationGroup.duration = animationDuration + nextPulseAfter
        self.animationGroup.repeatCount = numberOfPulses
        
        let defaultCurve = CAMediaTimingFunction(name : kCAMediaTimingFunctionDefault)
        
        self.animationGroup.timingFunction = defaultCurve
        
        
        self.animationGroup.animations = [createScaleAnimation() , createOpacityAnimation()]
    }
}
