//
//  CustomActivityIndicator.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 21/10/21.
//

import UIKit

@IBDesignable
public class CustomActivityIndicator: UIView {
    @IBInspectable
    /// Sets the color of the loading indicator
    public var color: UIColor = UIColor.common.accentColor0 {
        didSet {
            indicator.strokeColor = color.cgColor
        }
    }
    
    @IBInspectable
    /// sets the line width of the loading indicator
    public var lineWidth: CGFloat = 2.0 {
        didSet {
            indicator.lineWidth = lineWidth
            setNeedsLayout()
        }
    }
    
    private let indicator = CAShapeLayer()
    private let animator = CustomActivityIndicatorAnimator()
    
    /// Whether the indicator is animating or not
    private(set) var isAnimating = false
    
    convenience init() {
        self.init(frame: .zero)
        self.setup()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        indicator.strokeColor = color.cgColor
        indicator.fillColor = nil
        indicator.lineWidth = lineWidth
        indicator.strokeStart = 0.0
        indicator.strokeEnd = 0.0
        layer.addSublayer(indicator)
    }
    
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: 24, height: 24)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        indicator.frame = bounds
        
        let diameter = (CGFloat.minimum(bounds.size.width, bounds.size.height)) - indicator.lineWidth
        let path = UIBezierPath(center: CGPoint(x: bounds.midX, y: bounds.midY), radius: diameter / 2)
        indicator.path = path.cgPath
    }
}

extension CustomActivityIndicator {
    /// starts the animation on the indicator
    public func start() {
        isHidden = false
        guard indicator.animationKeys() == nil else { return }
        animator.addAnimation(to: indicator)
        isAnimating = true
    }
    
    /// Stops the animation on the indicator
    public func stop() {
        guard isAnimating else { return }
        animator.removeAnimation(from: indicator)
        isAnimating = false
    }
}
