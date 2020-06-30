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
    
    private func setShadows() {
        let backgroundColour = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor , opacity:Float = 0.3, blackOffset = CGSize(width: 5, height: 5), whiteOffset = CGSize(width: -5, height: -5), shadowRadius = CGFloat(5), cornerRadius = layer.frame.height / 2
        
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
    
    func hideShadows(_ isTrue: Bool) {
        layerW.isHidden = isTrue
        layerB.isHidden = isTrue
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setShadows()
        
        layer.cornerRadius = layer.frame.height / 2
        tintColor = UIColor.white
        setTitleColor(UIColor.white, for: .normal)
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        layer.insertSublayer(layerW, at: 0)
        layer.insertSublayer(layerB, at: 0)

    }

}

