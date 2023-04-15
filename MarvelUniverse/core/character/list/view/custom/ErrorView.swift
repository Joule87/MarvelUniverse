//
//  ErrorView.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 24/10/21.
//

import UIKit

typealias Action = () -> Void

class ErrorView: UIView {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "error_image")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var errorMessageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private lazy var retryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("retry".localized, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 24, weight: .bold)
        button.backgroundColor = .clear
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapRetryButton)))
        return button
    }()
    
    var retryAction: Action?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupImageView()
        setupErrorMessageLabel()
        setupRetryButton()
        backgroundColor = UIColor.common.appThemeBackground
    }
    
    private func setupImageView() {
        addSubview(imageView)
        NSLayoutConstraint.activate([imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                                     imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.40),
                                     imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.40),
                                     imageView.centerXAnchor.constraint(equalTo: centerXAnchor)])
    }
    
    private func setupErrorMessageLabel() {
        addSubview(errorMessageLabel)
        NSLayoutConstraint.activate([errorMessageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
                                     errorMessageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     errorMessageLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     errorMessageLabel.centerXAnchor.constraint(equalTo: centerXAnchor)])
    }
    
    private func setupRetryButton() {
        addSubview(retryButton)
        NSLayoutConstraint.activate([retryButton.topAnchor.constraint(equalTo: errorMessageLabel.bottomAnchor, constant: 5),
                                     retryButton.widthAnchor.constraint(equalTo: errorMessageLabel.widthAnchor, multiplier: 0.40),
                                     retryButton.heightAnchor.constraint(equalToConstant: 30),
                                     retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     retryButton.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)])
    }
    
    func set(error message: String?, color: UIColor = .white, font: UIFont = UIFont.boldSystemFont(ofSize: 20)) {
        errorMessageLabel.text = message
        errorMessageLabel.textColor = color
        errorMessageLabel.font = font
    }
    
    @objc private func didTapRetryButton() {
        retryAction?()
    }
}
