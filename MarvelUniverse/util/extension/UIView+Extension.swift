//
//  UIView+Extension.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 21/10/21.
//

import UIKit

extension UIView {
    /// Makes the views constraint equals to another view
    ///
    /// - Parameter other: UIView to pin this view to.
    func pinEdges(to other: UIView) {
        leadingAnchor.constraint(equalTo: other.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: other.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: other.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// Pins self to another view's center
    ///
    /// - Parameter other: UiView to center self into.
    func pinInCenter(to other: UIView) {
        centerXAnchor.constraint(equalTo: other.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: other.centerYAnchor).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }

}


extension UIView {
    /// Adds and shows an animated loading view on current view
    /// - Parameters:
    ///   - backColor: loading view background color
    ///   - activityStyle: style of the activityIndicator
    func showRegularLoader(backColor: UIColor? = nil, activityStyle: UIActivityIndicatorView.Style = .large) {
        let backView = UIView()
        let backViewIdentifier = ConstantViewIdentifier.regularLoader
        backView.backgroundColor = backColor != nil ? backColor : UIColor.white
        backView.frame = self.bounds
        backView.alpha = 0
        backView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backView.restorationIdentifier = backViewIdentifier
        backView.accessibilityIdentifier = backViewIdentifier
        
        let activityIndicator = UIActivityIndicatorView(style: activityStyle)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        
        backView.addSubview(activityIndicator)
        activityIndicator.center = backView.center
        
        self.addSubview(backView)
        self.bringSubviewToFront(backView)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            backView.alpha = 1
        }
    }
    
    /// Remove loading view if exist
    func removeRegularLoader() {
        let backViewIdentifier = ConstantViewIdentifier.regularLoader
        let loaderView = self.subviews.filter { $0.accessibilityIdentifier == backViewIdentifier || $0.restorationIdentifier == backViewIdentifier }.first
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            loaderView?.alpha = 0
        } completion: { _ in
            loaderView?.removeFromSuperview()
        }
        
    }
}
