//
//  CTextField.swift
//  FoodMenuApp
//
//

import Foundation
import UIKit
import SkyFloatingLabelTextField

class CTextField: SkyFloatingLabelTextField {
    private let leftPadding = CGFloat(10)
    private let rightPadding = CGFloat(10)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
        tintColor = .systemGray
        selectedTitleColor = .systemGray2
        titleColor = .systemGray2
        lineHeight = 0.0
        selectedLineHeight = 0.0
        selectedLineColor = .systemGray5
        titleFormatter = { text in
            return text
        }
        backgroundColor = .systemGray6
        layer.sublayerTransform = CATransform3DMakeTranslation(0,-4,0)
        layer.cornerRadius = 10
        autocorrectionType = .no
        translatesAutoresizingMaskIntoConstraints = false
    }
    override func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        if editing {
            return CGRect(x: leftPadding, y: 10, width: bounds.size.width, height: titleHeight())
        }
        return CGRect(x: leftPadding, y: titleHeight(), width: bounds.size.width, height: titleHeight())
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let rect = CGRect(
                    x: leftPadding,
                    y: titleHeight(),
                    width: bounds.size.width - rightPadding,
                    height: bounds.size.height - titleHeight() - selectedLineHeight
        )
        return rect
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = CGRect(
                    x: leftPadding,
                    y: titleHeight(),
                    width: bounds.size.width - rightPadding,
                    height: bounds.size.height - titleHeight() - selectedLineHeight
        )
        return rect
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = CGRect(
                    x: leftPadding,
                    y: titleHeight(),
                    width: bounds.size.width - rightPadding,
                    height: bounds.size.height - titleHeight() - selectedLineHeight
        )
        return rect
    }
    override func becomeFirstResponder() -> Bool {
        if self.text!.isEmpty {
            placeholder = ""
            setTitleVisible(true, animated: true, animationCompletion: nil)
        }
       
        return super.becomeFirstResponder()
    }
    override func resignFirstResponder() -> Bool {
        if self.text!.isEmpty {
            placeholder = title
        }
        setTitleVisible(false, animated: true, animationCompletion: nil)
        return super.resignFirstResponder()
    }
}
