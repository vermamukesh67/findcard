//
//  FCUIViewExtension.swift
//  FindCard
//
//  Created by Varma Mukesh on 12/05/20.
//  Copyright © 2020 com.mukesh. All rights reserved.
//

import Foundation
import UIKit
/// CompletionHandler type alias.
public typealias CompletionHandler = () -> Void

extension UIView {
    /// fix the constraint from the all corner.
    func fixConstraintsInView(_ container: UIView!) {
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    /// Flips the view.
    @objc func flip(direction: UIView.AnimationOptions, duration: TimeInterval, completionHandler: CompletionHandler? = nil) {
        let transitionOptions: UIView.AnimationOptions = [direction, .showHideTransitionViews]
        UIView.transition(with: self, duration: duration, options: transitionOptions, animations: nil, completion: { _ in
            completionHandler?()
        })
    }
}
