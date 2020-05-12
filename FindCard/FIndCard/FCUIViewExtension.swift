//
//  FCUIViewExtension.swift
//  FindCard
//
//  Created by Chandresh Maurya on 12/05/20.
//  Copyright © 2020 com.mukesh. All rights reserved.
//

import Foundation
import UIKit

public typealias CompletionHandler = () -> Void

extension UIView {
    @discardableResult   // 1
       func fromNib<T : UIView>() -> T? {   // 2
           guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {    // 3
               // xib not loaded, or its top view is of the wrong type
               return nil
           }
           self.addSubview(contentView)     // 4
           contentView.translatesAutoresizingMaskIntoConstraints = false   // 5
           contentView.fixConstraintsInView(self)   // 6
           return contentView   // 7
       }
    // load view from playground bundle
    func fromNib<T: UIView>(nibName: String) -> T? {
        let podBundle = self.bundle()
        if let bundleURL = podBundle.url(forResource: "Playground", withExtension: "bundle") {
            if let bundle = Bundle(url: bundleURL) {
                guard let contentView =  bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as? T else {
                    // xib not loaded, or its top view is of the wrong type
                    return nil
                }
                contentView.backgroundColor = .clear
                self.addSubview(contentView)
                contentView.translatesAutoresizingMaskIntoConstraints = false
                contentView.fixConstraintsInView(self)
                return contentView
            }
        }
        return nil
    }
    
    // fix the constraint, use it when load view from bundle
    func fixConstraintsInView(_ container: UIView!) {
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
    // returns the playground bundle
    func bundle() -> Bundle {
        let bundle = Bundle.main
        return bundle
    }
    @objc func flip(firstView: UIView, secondView: UIView, direction:UIView.AnimationOptions, duration: TimeInterval, completionHandler: @escaping CompletionHandler) {
        let transitionOptions: UIView.AnimationOptions = [direction, .showHideTransitionViews]

        UIView.transition(with: firstView, duration: duration, options: transitionOptions, animations: {
            firstView.isHidden = true
            completionHandler()
        })
        UIView.transition(with: secondView, duration: duration, options: transitionOptions, animations: {
            secondView.isHidden = false
        })
    }
    @objc func flip(direction:UIView.AnimationOptions, duration: TimeInterval, completionHandler: @escaping CompletionHandler) {
        let transitionOptions: UIView.AnimationOptions = [direction, .showHideTransitionViews]
        UIView.transition(with: self, duration: duration, options: transitionOptions, animations: {
            completionHandler()
        })
    }
}
