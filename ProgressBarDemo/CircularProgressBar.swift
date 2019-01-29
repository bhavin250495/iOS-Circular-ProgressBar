//
//  CircularProgressBar.swift
//  EmbroideryMonitor
//
//  Created by Bhavin Suthar on 20/11/18.
//  Copyright © 2018 husqvarnaviking. All rights reserved.
//

import UIKit

@IBDesignable
class CircularProgressBar: UIView {

    var bgPathTopLevel:UIBezierPath!
    var topLevelShapeLayer:CAShapeLayer!
    var topLevelProgressLayer:CAShapeLayer!
    var bgPathSubLevel:UIBezierPath!
    var subLevelShapeLayer:CAShapeLayer!
    var subLevelProgressLayer:CAShapeLayer!
    var progressText:UILabel!
    
    @IBInspectable var showProgressText:Bool = false
    
   @IBInspectable var innerProgress:CGFloat = 0 {
        willSet(newValue) {
            
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = innerProgress
            animation.toValue = newValue
            animation.duration = 0
            animation.duration = 1
            subLevelProgressLayer.add(animation, forKey: "drawLineAnimation")
            
        }
    }
    
   @IBInspectable var outerProgress:CGFloat = 0 {
        willSet(newValue) {
            
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = outerProgress
            animation.toValue = newValue
            animation.duration = 0
            animation.duration = 0.5
            topLevelProgressLayer.add(animation, forKey: "drawLineAnimation")
            
        }
    }
    @IBInspectable var innerThickness:CGFloat = 10.0 {
        willSet(newValue){
            
            subLevelShapeLayer.lineWidth = newValue
            subLevelProgressLayer.lineWidth = newValue
        }
    }
    @IBInspectable var progress:CGFloat = 0.0 {
        willSet (newValue) {
            if showProgressText {
                var preogressStr = ""
                
                if (0 ... 1).contains(newValue){
                    
                    preogressStr = String.init(format: "%d%@", Int(newValue*100),"%")
                }else {
                    preogressStr = String.init(format: "%d%@", 100,"%")
                }
                self.progressText.text = preogressStr
            }
          
            
        }
    }
    @IBInspectable var outerThickness:CGFloat  = 5.0{
        willSet(newValue){
            
            topLevelShapeLayer.lineWidth = newValue
            topLevelProgressLayer.lineWidth = newValue
            
        }
    }
    
    @IBInspectable var outerProgressColor:UIColor = UIColor.blue {
        willSet(newValue){
            
            topLevelProgressLayer.strokeColor = newValue.cgColor
            
        }
    }
  
  @IBInspectable  var innerProgressColor:UIColor = UIColor.clear {
        willSet(newValue) {
            subLevelProgressLayer.strokeColor = newValue.cgColor
        }
    }
    
    @IBInspectable public var thickness:CGFloat = 5
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        simpleShape()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        simpleShape()
    }
    
    override func draw(_ rect: CGRect) {
        self.transform = CGAffineTransform(rotationAngle: CGFloat((Double.pi/2) * -1));
        self.backgroundColor = UIColor.clear
        simpleShape()
    }
    private func createCirclePath() {
        let x = self.bounds.width/2
        let y = self.bounds.height/2
        
        let center = CGPoint(x: x, y: y)
        
        bgPathTopLevel = UIBezierPath.init()
        
        bgPathTopLevel.addArc(withCenter: center, radius: x-10, startAngle: CGFloat(0), endAngle: CGFloat(2*(Double.pi)), clockwise: true)
        
        bgPathSubLevel = UIBezierPath.init()
        bgPathSubLevel.addArc(withCenter: center, radius: x-25, startAngle: CGFloat(0), endAngle: CGFloat(2*(Double.pi)), clockwise: true)
        
        bgPathSubLevel.close()
        
        bgPathTopLevel.close()
        
        if showProgressText {
            progressText = UILabel.init(frame: CGRect.init(x: 0, y: 0, width:(x-25) * 2, height: (x-25) * 2))
            progressText.textColor = UIColor.black
            progressText.text = "0%"
            progressText.textAlignment = .center
            self.addSubview(progressText)
            progressText.backgroundColor = UIColor.clear
            progressText.center = center
            progressText.font = UIFont.systemFont(ofSize:(x-25)/2 )
            progressText.transform = CGAffineTransform(rotationAngle: CGFloat((Double.pi/2)));
        }
        
    }
    
    
    func simpleShape() {
        createCirclePath()
        
        topLevelShapeLayer = CAShapeLayer()
        topLevelShapeLayer.path = bgPathTopLevel.cgPath
        topLevelShapeLayer.lineWidth = outerThickness
        topLevelShapeLayer.fillColor = nil
        topLevelShapeLayer.strokeColor = UIColor.lightGray.cgColor
        
        topLevelProgressLayer = CAShapeLayer()
        topLevelProgressLayer.path = bgPathTopLevel.cgPath
        topLevelProgressLayer.lineWidth = outerThickness
        topLevelProgressLayer.lineCap = CAShapeLayerLineCap.round
        topLevelProgressLayer.fillColor = nil
        topLevelProgressLayer.strokeColor = outerProgressColor.cgColor
        topLevelProgressLayer.strokeEnd = outerProgress
        
        self.layer.addSublayer(topLevelShapeLayer)
        self.layer.addSublayer(topLevelProgressLayer)
        
        subLevelShapeLayer = CAShapeLayer()
        subLevelShapeLayer.path = bgPathSubLevel.cgPath
        subLevelShapeLayer.lineWidth = innerThickness
        subLevelShapeLayer.fillColor = nil
        subLevelShapeLayer.strokeColor = UIColor.lightGray.cgColor
        
        subLevelProgressLayer = CAShapeLayer()
        subLevelProgressLayer.path = bgPathSubLevel.cgPath
        subLevelProgressLayer.lineWidth = innerThickness
        subLevelProgressLayer.lineCap = CAShapeLayerLineCap.round
        subLevelProgressLayer.fillColor = nil
        subLevelProgressLayer.strokeColor = innerProgressColor.cgColor
        subLevelProgressLayer.strokeEnd = innerProgress

        self.layer.addSublayer(subLevelShapeLayer)
        
        self.layer.addSublayer(subLevelProgressLayer)
        
        
       
    }
    
}
