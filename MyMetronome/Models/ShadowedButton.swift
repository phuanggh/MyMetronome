//
//  ShadowedButton.swift
//  MyMetronome
//
//  Created by Penny Huang on 2020/6/28.
//  Copyright © 2020 Penny Huang. All rights reserved.
//

import UIKit

class ShadowedButton: UIButton {
    
    let layerW = CALayer()
    let layerB = CALayer()
    
    private let backgroundColour = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor , opacity:Float = 0.3, blackOffset = CGSize(width: 5, height: 5), whiteOffset = CGSize(width: -5, height: -5), shadowRadius = CGFloat(5)
    
    private func setShadow() {
        layerW.frame = layer.bounds
        layerW.cornerRadius = layer.frame.height / 2
        layerW.backgroundColor = backgroundColour
        layerW.shadowColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layerW.shadowOpacity = opacity
        layerW.shadowRadius = shadowRadius
        layerW.shadowOffset = whiteOffset

        layerB.frame = layer.bounds
        layerB.cornerRadius = layer.frame.height / 2
        layerB.backgroundColor = backgroundColour
        layerB.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layerB.shadowOpacity = opacity
        layerW.shadowRadius = shadowRadius
        layerB.shadowOffset = blackOffset
    }
    
    func hideShadow(_ isTrue: Bool) {
        layerW.isHidden = isTrue
        layerB.isHidden = isTrue
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setShadow()
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.cornerRadius = layer.frame.height / 2
        tintColor = UIColor.white
        setTitleColor(UIColor.white, for: .normal)
        
        layer.insertSublayer(layerW, at: 0)
        layer.insertSublayer(layerB, at: 0)

    }

}

