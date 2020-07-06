//
//  ShadowedBPM.swift
//  MyMetronome
//
//  Created by Penny Huang on 2020/7/4.
//  Copyright © 2020 Penny Huang. All rights reserved.
//

import UIKit

class ShadowedBPM: UIView {
    
    let layerBlueL = CALayer()
    let layerBlueR = CALayer()
    let layerBlue = CALayer()
    let layerW = CALayer()
    let layerB = CALayer()
//    let newLayerW = CAShapeLayer()
    let maxGlowSize = 15, minGlowSize = 0, animDuration = 2
    
    
    private func setShadows() {
        let backgroundColour = #colorLiteral(red: 0.3254901961, green: 0.3215686275, blue: 0.3450980392, alpha: 1).cgColor, opacity:Float = 0.3, blackOffset = CGSize(width: 5, height: 5), whiteOffset = CGSize(width: -5, height: -5), shadowRadius = CGFloat(5), cornerRadius = layer.frame.height / 2
        
        layerW.frame = layer.bounds

        layerW.cornerRadius = cornerRadius
        layerW.backgroundColor = backgroundColour
        layerW.shadowColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layerW.shadowOpacity = opacity
        layerW.shadowRadius = shadowRadius
        layerW.shadowOffset = .zero
        
//        newLayerW.backgroundColor = backgroundColour
//        newLayerW.shadowColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        newLayerW.shadowOpacity = opacity
//        newLayerW.lineWidth = 3
//        newLayerW.strokeColor = UIColor.black.cgColor
//        let arcCenter:CGPoint = newLayerW.position
//        let radius:CGFloat = 95
//        let path = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: 0, endAngle: CGFloat(2 * Float.pi), clockwise: true)
//        newLayerW.path = path.cgPath
//        newLayerW.position = center
        
//
        layerB.frame = layer.bounds
        layerB.cornerRadius = cornerRadius
        layerB.backgroundColor = backgroundColour
        layerB.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layerB.shadowOpacity = opacity
        layerB.shadowRadius = shadowRadius
        layerB.shadowOffset = blackOffset
    }
    
    func hideShadows(_ isTrue: Bool) {
        layerW.isHidden = isTrue
        layerB.isHidden = isTrue
    }
    
    func showLayerBlue() {
        let backgroundColour = #colorLiteral(red: 0.3254901961, green: 0.3215686275, blue: 0.3450980392, alpha: 1).cgColor, opacity:Float = 1, blackOffset = CGSize(width: 5, height: 5), whiteOffset = CGSize(width: -5, height: -5), shadowRadius = CGFloat(20), cornerRadius = layer.frame.height / 2, shadowColour = #colorLiteral(red: 0.6117647059, green: 0.9529411765, blue: 1, alpha: 1).cgColor
        
//        layerBlueL.frame = layer.bounds
//
//        layerBlueL.cornerRadius = cornerRadius
//        layerBlueL.backgroundColor = backgroundColour
//        layerBlueL.shadowColor = shadowColour
//        layerBlueL.shadowOpacity = opacity
//        layerBlueL.shadowRadius = shadowRadius
//        layerBlueL.shadowOffset = whiteOffset
//
//        layerBlueR.frame = layer.bounds
//        layerBlueR.cornerRadius = cornerRadius
//        layerBlueR.backgroundColor = backgroundColour
//        layerBlueR.shadowColor = shadowColour
//        layerBlueR.shadowOpacity = opacity
//        layerBlueR.shadowRadius = shadowRadius
//        layerBlueR.shadowOffset = blackOffset
        
        layerBlue.frame = layer.bounds
        layerBlue.cornerRadius = cornerRadius
        layerBlue.backgroundColor = backgroundColour
        layerBlue.shadowColor = shadowColour
        layerBlue.shadowOpacity = opacity
        layerBlue.shadowRadius = CGFloat(maxGlowSize)
        layerBlue.shadowOffset = .zero
//        layerBlue.shadowPath = CGPath(roundedRect: layer.bounds, cornerWidth: cornerRadius, cornerHeight: cornerRadius, transform: nil)
        
        layer.insertSublayer(layerBlue, at: 0)
//        layer.insertSublayer(layerBlueL, at: 0)
//        layer.insertSublayer(layerBlueR, at: 0)
    }
    
    func startAnimation() {

        
        let layerAnimation = CABasicAnimation(keyPath: "shadowRadius")
        layerAnimation.fromValue = maxGlowSize
        layerAnimation.toValue = minGlowSize
        layerAnimation.autoreverses = true
        layerAnimation.isAdditive = false
        layerAnimation.duration = CFTimeInterval(animDuration/2)
        layerAnimation.fillMode = CAMediaTimingFillMode.forwards
        layerAnimation.isRemovedOnCompletion = false
        layerAnimation.repeatCount = .infinity
        self.layerBlue.add(layerAnimation, forKey: "glowingAnimation")
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.contentScaleFactor = UIScreen.main.scale
//        self.layer.masksToBounds = false
//
//        self.startAnimation()
//
//    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setShadows()
        showLayerBlue()
//        startAnimation()
//        layer.backgroundColor = #colorLiteral(red: 0.3254901961, green: 0.3215686275, blue: 0.3450980392, alpha: 1)
        layer.cornerRadius = layer.frame.height / 2
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.insertSublayer(layerW, at: 0)
        layer.insertSublayer(layerB, at: 0)

//        layer.insertSublayer(layerBlueL, at: 0)
//        layer.insertSublayer(layerBlueR, at: 0)

    }

    
}
