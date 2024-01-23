//
//  ButtonView.swift
//  Week8 MVCPattern
//
//  Created by Elton Ruhani @Kin+Carta on 22.1.24.
//

import Foundation
import UIKit

class Button: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        // Customize button appearance here
        setTitleColor(.white, for: .normal)
        backgroundColor = UIColor(named: "BackgroundC")
        
        layer.cornerRadius = 8
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }

//TODO: Add animation to button on touch
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        animateTouch()
//    }
    
    func animateTouch() {
        UIView.animate(withDuration: 0.3) {
            self.layer.opacity = 0.5
            self.layer.opacity = 1
        }
    }
    
}
