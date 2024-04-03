//
//  UIViewControllerExtension.swift
//  MovieApp
//
//  Created by Admin on 02/04/24.
//

import Foundation
import UIKit
extension UIViewController {
    func showToast(message : String, font: UIFont) {
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 14)
        toastLabel.textColor = UIColor.white
        toastLabel.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.2509803922, blue: 0.3215686275, alpha: 1)
        toastLabel.numberOfLines = 0
        
        let textSize = toastLabel.intrinsicContentSize
        let labelHeight = ( textSize.width / window.frame.width) * 30
        let labelWidth = min(textSize.width, window.frame.width - 40)
        let adjustedHeight = max(labelHeight, textSize.height + 20)
        
        toastLabel.frame = CGRect(x: 20, y: (window.frame.height - 90) - adjustedHeight, width: labelWidth + 20, height: adjustedHeight)
        toastLabel.center.x = window.center.x
        toastLabel.layer.cornerRadius = 10
        toastLabel.layer.masksToBounds = true
        window.addSubview(toastLabel)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            toastLabel.removeFromSuperview()
        }
    }
}
