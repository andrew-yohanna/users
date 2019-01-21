//
//  UIView+Anchor.swift
//  DouughUsers
//
//  Created by Andrew Yohanna on 21/1/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import UIKit

extension UIView {
    /// Helper method that sets frequent constraints for UIView
    ///
    /// - Parameters:
    ///   - top: if not nil sets top anchor of view
    ///   - leading: if not nil sets leading anchor of view
    ///   - bottom: if not nil sets bottom anchor of view
    ///   - trailing: if not nil sets trailing anchor of view
    ///   - padding: sets the padding on the top, leading, bottom, trailing anchors. Default is zero padding
    ///   - size: sets the width and the height anchors of the view. If 0 the constraint is not set.
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
