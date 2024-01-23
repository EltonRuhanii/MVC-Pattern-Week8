//
//  TitledTextFieldView.swift
//  Week8-MVCPattern
//
//  Created by Elton Ruhani @Kin+Carta on 22.1.24.
//

import Foundation
import UIKit

class TextFieldView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()

    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        return textField
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        addSubview(titleLabel)
        addSubview(textField)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])

        // Configure textField delegate to handle placeholder behavior
        textField.delegate = self
    }

    func configure(title: String, secure: Bool = false) {
        titleLabel.text = title
        if secure {
            textField.isSecureTextEntry = true
        }
    }
}

extension TextFieldView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Hide the placeholder when editing begins
        textField.placeholder = nil
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // Show the placeholder if the text field is empty
        if textField.text?.isEmpty ?? true {
            textField.placeholder = titleLabel.text
        }
    }
}
