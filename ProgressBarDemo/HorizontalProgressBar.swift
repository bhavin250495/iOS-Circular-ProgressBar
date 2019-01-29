//
//  HorizontalProgressBar.swift
//  EmbroideryMonitor
//
//  Created by Bhavin Suthar on 07/01/19.
//  Copyright © 2019 husqvarnaviking. All rights reserved.
//

import UIKit
import Foundation

class HorizontalProgressBar: UIView {
    
    fileprivate var backgroundPath:UIBezierPath!
    fileprivate var backgroundShape:CAShapeLayer!
    
    fileprivate var foregroundPath:UIBezierPath!
    fileprivate var foregroundShape:CAShapeLayer!
    
    fileprivate var textLayer:CATextLayer!
    
    @IBInspectable var barColor:UIColor = UIColor.darkGray
    
    @IBInspectable var progressColor:UIColor = UIColor.red {
        didSet {
            
            if foregroundPath != nil {
               updateStrokeColor()
            }
        }
    }
    
    @IBInspectable var borderColor:UIColor = UIColor.white {
        didSet  {
        
            self.layer.borderColor = self.borderColor.cgColor
        }
    }
    
    @IBInspectable var showProgressText:Bool = false
    
    @IBInspectable var progressFont:UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    
    
    fileprivate var prevProgress:CGFloat = 0
    
    
    @IBInspectable public var progress:CGFloat = 0 {
        
        willSet{
            
            prevProgress = progress
        }
        didSet {
            
            guard foregroundShape != nil else {
                return
            }
            incrementProgress()
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        setup()
        layoutComponents()
        
        self.layer.cornerRadius = 2
        self.layer.borderWidth = 1        
        self.layer.borderColor = self.borderColor.cgColor
        
    }
    
    fileprivate func incrementProgress() {
        
        foregroundShape.strokeEnd = progress
        
        if progress > 0.1 {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = prevProgress
            animation.toValue = progress
            animation.duration = 0
            animation.duration = 2.5
            foregroundShape.add(animation, forKey: "drawLineAnimation")
        }
        
        if showProgressText {
            self.textLayer.string = String.init(format: "%d %@", Int(progress*100),"%")
        }
    }
    
    fileprivate func layoutComponents() {
        
        backgroundPath = UIBezierPath.init()
        backgroundPath.move(to: CGPoint.init(x: 0, y: 0))
        backgroundPath.addLine(to: CGPoint.init(x: self.bounds.width, y: 0))
        
        
        backgroundShape = CAShapeLayer.init()
        backgroundShape.path = backgroundPath.cgPath
        backgroundShape.strokeColor = self.barColor.cgColor
        backgroundShape.lineWidth = self.bounds.width
        
        
        foregroundPath = UIBezierPath.init()
        foregroundPath.move(to: CGPoint.init(x: 0, y: 0))
        foregroundPath.addLine(to: CGPoint.init(x: self.bounds.width, y: 0))
        
        foregroundShape = CAShapeLayer.init()
        foregroundShape.path = foregroundPath.cgPath
        foregroundShape.strokeColor = self.progressColor.cgColor
        foregroundShape.strokeEnd = 0
        foregroundShape.lineWidth = self.bounds.width
        
        self.layer.addSublayer(backgroundShape)
        self.layer.addSublayer(foregroundShape)
        if showProgressText{
            addTextLayer()
        }
    }
    fileprivate func  updateStrokeColor() {
        
        foregroundShape.strokeColor = self.progressColor.cgColor
        
    }
    
    fileprivate func addTextLayer() {
        
        textLayer  = CATextLayer.init()
        textLayer.frame = CGRect.init(x: 0, y: 0 , width: self.layer.bounds.width, height: self.layer.bounds.height)
        textLayer.alignmentMode = .center
        textLayer.foregroundColor = UIColor.white.cgColor
        self.layer.addSublayer(textLayer)
        textLayer.string = ""
        textLayer.font = progressFont
        textLayer.fontSize = (self.layer.bounds.height * 0.7)
        
        textLayer.shadowColor = UIColor.black.cgColor
        textLayer.shadowOffset = CGSize.init(width: 0.5, height:0.5)
        
        textLayer.contentsScale = UIScreen.main.scale
        self.layer.addSublayer(textLayer)
        self.textLayer.string = String.init(format: "%d %@", Int(progress*100),"%")
    }
    
    fileprivate func setup(){
        self.clipsToBounds = true
    }
    
    
    
    
}
