//
//  CharacterProfileView.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 22/10/21.
//

import UIKit

class CharacterProfileView: UIView {
    
    lazy var topBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "outspace")
        return imageView
    }()
    
    lazy var bottomBackgroundView: UIView = {
        let imageView = UIView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.common.appThemeBackground
        return imageView
    }()
    
    lazy var profileNetworkImageView: NetworkImageView = {
        let view = NetworkImageView()
        view.backgroundColor = UIColor.common.appThemeBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var gradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func set(imageURL: String) {
        profileNetworkImageView.loadImageFrom(url: imageURL)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setProfileImageViewShadow()
        setGradientLayer()
    }
    
    private func commonInit() {
        setupProfileNetworkImageView()
        setupTopBackgroundImageView()
        setupBottomBackgroundView()
        setupGradientView()
    }
    
    private func setupTopBackgroundImageView() {
        addSubview(topBackgroundImageView)
        NSLayoutConstraint.activate([topBackgroundImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                                     topBackgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                                     topBackgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                                     topBackgroundImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.67)])
        sendSubviewToBack(topBackgroundImageView)
    }
    
    private func setupBottomBackgroundView() {
        addSubview(bottomBackgroundView)
        NSLayoutConstraint.activate([bottomBackgroundView.topAnchor.constraint(equalTo: topBackgroundImageView.bottomAnchor, constant: 0),
                                     bottomBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                                     bottomBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                                     bottomBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)])
        sendSubviewToBack(bottomBackgroundView)
    }
    
    private func setupProfileNetworkImageView() {
        addSubview(profileNetworkImageView)
        NSLayoutConstraint.activate([profileNetworkImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.70),
                                     profileNetworkImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.70),
                                     profileNetworkImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     profileNetworkImageView.centerXAnchor.constraint(equalTo: centerXAnchor)])
    }
    
    private func setupGradientView() {
        topBackgroundImageView.addSubview(gradientView)
        NSLayoutConstraint.activate([gradientView.topAnchor.constraint(equalTo: topBackgroundImageView.bottomAnchor, constant: -20),
                                     gradientView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                                     gradientView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                                     gradientView.heightAnchor.constraint(equalToConstant: 30)])
    }
    
    private func setGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.frame = gradientView.bounds
        gradient.colors = [UIColor.clear.cgColor,  #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1).cgColor]
        gradientView.layer.insertSublayer(gradient, at: 0)
    }
    
    private func setProfileImageViewShadow() {
        profileNetworkImageView.applyShadow(cornerRadius: frame.height * 0.70 / 2)
    }
    
}


