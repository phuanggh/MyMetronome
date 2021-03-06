//
//  ShadowedBPM.swift
//  MyMetronome
//
//  Created by Penny Huang on 2020/7/4.
//  Copyright © 2020 Penny Huang. All rights reserved.
//

import UIKit

class ShadowedBPM: UIView {
    
    let layerBlue = CALayer()
    let layerW = CALayer()
    let layerB = CALayer()
    
    // Glow
    let maxGlowSize = 25, minGlowSize = 0, firstBeatColour = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor, otherBeatColour = #colorLiteral(red: 0.6117647059, green: 0.9529411765, blue: 1, alpha: 1).cgColor
    
    private func setShadows() {
        let backgroundColour = #colorLiteral(red: 0.3254901961, green: 0.3215686275, blue: 0.3450980392, alpha: 1).cgColor, opacity:Float = 0.3, blackOffset = CGSize(width: 5, height: 5), whiteOffset = CGSize(width: -5, height: -5), shadowRadius = CGFloat(5), cornerRadius = layer.cornerRadius
        
        layerW.frame = layer.bounds
        layerW.cornerRadius = cornerRadius
        layerW.backgroundColor = backgroundColour
        layerW.shadowColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layerW.shadowOpacity = opacity
        layerW.shadowRadius = shadowRadius
        layerW.shadowOffset = whiteOffset

        layerB.frame = layer.bounds
        layerB.cornerRadius = cornerRadius
        layerB.backgroundColor = backgroundColour
        layerB.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layerB.shadowOpacity = opacity
        layerB.shadowRadius = shadowRadius
        layerB.shadowOffset = blackOffset
    }
    
    private func setBlueShadow() {
        let backgroundColour = #colorLiteral(red: 0.3254901961, green: 0.3215686275, blue: 0.3450980392, alpha: 1).cgColor, opacity:Float = 1, cornerRadius = layer.cornerRadius, shadowColour = #colorLiteral(red: 0.6117647059, green: 0.9529411765, blue: 1, alpha: 1).cgColor
        
        layerBlue.frame = layer.bounds
        layerBlue.cornerRadius = cornerRadius
        layerBlue.backgroundColor = backgroundColour
        layerBlue.shadowColor = shadowColour
        layerBlue.shadowOpacity = opacity
        layerBlue.shadowRadius = CGFloat(minGlowSize)
        layerBlue.shadowOffset = .zero
        
        layer.insertSublayer(layerBlue, at: 0)

    }
    
    func startGlowingAnimation(duration: Double) {

        let layerAnimation = CABasicAnimation(keyPath: "shadowRadius")
        layerAnimation.fromValue = minGlowSize
        layerAnimation.toValue = maxGlowSize
        layerAnimation.autoreverses = true
        layerAnimation.isAdditive = false
        layerAnimation.duration = CFTimeInterval(duration/2)
        layerAnimation.fillMode = CAMediaTimingFillMode.forwards
        layerAnimation.isRemovedOnCompletion = false
        layerAnimation.repeatCount = .infinity
        self.layerBlue.add(layerAnimation, forKey: "glowingAnimation")
    }
    
    func stopAnimation() {
        layerBlue.shadowColor = #colorLiteral(red: 0.6117647059, green: 0.9529411765, blue: 1, alpha: 1).cgColor
        layerBlue.removeAllAnimations()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // BPM View
        if layer.frame.height > 100 {
            layer.cornerRadius = layer.frame.height / 2
            setShadows()
            setBlueShadow()
            
        // Beat Bar View
        } else {
            layer.cornerRadius = 16
            setShadows()
        }
        
        layer.insertSublayer(layerW, at: 0)
        layer.insertSublayer(layerB, at: 0)

    }

}
