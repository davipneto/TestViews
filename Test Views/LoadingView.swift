//
//  LoadingView.swift
//  Test Views
//
//  Created by Curitiba01 on 11/09/21.
//  Copyright © 2021 Curitiba01. All rights reserved.
//

import UIKit

class LoadingView {
    static let shared = LoadingView()
    
    let mainView = UIView(frame: UIScreen.main.bounds)
    let blurView = UIView()
    let backgroundView = UIView()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    let label = UILabel()
    
    fileprivate init() {
        blurView.backgroundColor = .black
        blurView.alpha = 0.5
        
        mainView.addSubview(blurView)
        blurView.fillSuperview()
         
        activityIndicator.startAnimating()
        label.text = "Loading..."
        
        backgroundView.backgroundColor = .lightGray
        backgroundView.layer.cornerRadius = 10
        
        mainView.addSubview(backgroundView)
        backgroundView.centerOfSuperview()
        backgroundView.defineSize(width: 150, height: 150)
        
        let stackView = UIStackView(arrangedSubviews: [activityIndicator, label])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        
        backgroundView.addSubview(stackView)
        stackView.centerOfSuperview()
    }
    
    func show() {
        DispatchQueue.main.async {
            UIApplication.shared.windows.first?.addSubview(self.mainView)
        }
    }
    
    func hide() {
        DispatchQueue.main.async {
            self.mainView.removeFromSuperview()
        }
    }
}
