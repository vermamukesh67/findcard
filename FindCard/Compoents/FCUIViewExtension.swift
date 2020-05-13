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
    /// Flips the view.
    @objc func flip(direction: UIView.AnimationOptions, duration: TimeInterval, completionHandler: CompletionHandler? = nil) {
        let transitionOptions: UIView.AnimationOptions = [direction, .showHideTransitionViews]
        UIView.transition(with: self, duration: duration, options: transitionOptions, animations: nil, completion: { _ in
            completionHandler?()
        })
    }
}
