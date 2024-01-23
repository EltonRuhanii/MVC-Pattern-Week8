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
    
    // You can add additional methods or properties as needed
    
}
