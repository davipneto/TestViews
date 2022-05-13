//
//  UIView+Constraint.swift
//  Test Views
//
//  Created by Curitiba01 on 11/09/21.
//  Copyright © 2021 Curitiba01. All rights reserved.
//

import UIKit

extension UIView {
    func prepareForConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func fillSuperview(constant: CGFloat = 0) {
        guard let superview = superview else { return }
        prepareForConstraints()
        
        topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: constant).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: constant).isActive = true
    }
    
    func centerOfSuperview(horizontal: Bool = true, vertical: Bool = true) {
        guard let superview = superview else { return }
        prepareForConstraints()
        
        if horizontal {
            centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        }
        if vertical {
            centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        }
    }
    
    func defineSize(width: CGFloat? = nil, height: CGFloat? = nil) {
        prepareForConstraints()
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
