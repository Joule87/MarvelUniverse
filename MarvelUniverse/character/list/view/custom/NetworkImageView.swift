//
//  NetworkImageView.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 21/10/21.
//

import UIKit

let imageDataCache = NSCache<AnyObject, AnyObject>()

class NetworkImageView: UIView {
    private let indicator = CustomActivityIndicator()
    private let imageView = UIImageView()
    private var lastUrl: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setupIndicator()
        setupImageView()
    }
    
    private func setupIndicator() {
        addSubview(indicator)
        indicator.pinInCenter(to: self)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.heightAnchor.constraint(equalToConstant: 30).isActive = true
        indicator.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.pinEdges(to: self)
        imageView.contentMode = .scaleAspectFill
    }
    
    private func showLoadedImage(_ img: UIImage, for url: String) {
        guard url == lastUrl else {
            return
        }
        DispatchQueue.main.async {
                self.imageView.image = img
                self.indicator.stop()
                self.indicator.isHidden = true
                self.imageView.isHidden = false
            UIView.animate(withDuration: 0.08) {
                self.imageView.alpha = 1
            }
        }
    }
    
    private func showLoadingAnimation() {
        DispatchQueue.main.async {
                self.imageView.image = nil
                self.indicator.start()
                self.indicator.isHidden = false
                self.imageView.isHidden = true
            UIView.animate(withDuration: 0.08) {
                self.imageView.alpha = 0
            }
        }
    }
    
    private func showPlaceholder() {
        guard let placeholderImage = UIImage(named: "placeholder_product") else { return }
        DispatchQueue.main.async {
                self.imageView.image = placeholderImage
                self.indicator.stop()
                self.indicator.isHidden = true
                self.imageView.isHidden = false
            UIView.animate(withDuration: 0.08) {
                self.imageView.alpha = 1
            }
        }
    }
    
    private func setNotFoundImagePlaceholder(for imageURL: String) {
        guard let placeholderImage = UIImage(named: "placeholder_product") else {
            return
        }
        showLoadedImage(placeholderImage, for: imageURL)
    }
    
    /// Gets requested image from url and shows it. If image is not in cache it will perform a new request
    ///
    /// - Parameter imageURL: image url
    /// - Parameter downloader: image downloader
    private func requestImage(from imageURL: String, downloader: Downloadable = ImageDownloader()) {
        downloader.fetch(from: imageURL) { [weak self] data in
            guard let self = self else { return }
            guard let data = data, let image = UIImage(data: data) else {
                self.setNotFoundImagePlaceholder(for: imageURL)
                return
            }
            self.showLoadedImage(image, for: imageURL)
        }
    }
    
    /// Loads and caches images from urls, if image has been loaded before it will load the cached image instead of making new request.
    /// and while image loads, an activity indicator is shown.
    ///
    /// - Parameter url: url of the image
    func loadImageFrom(url: String) {
        lastUrl = url
        showLoadingAnimation()
        requestImage(from: url)
    }
}

extension NetworkImageView {
    func applyShadow(cornerRadius : CGFloat, shadowRadius: CGFloat = 20) {
        clipsToBounds = false
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = shadowRadius
        layer.cornerRadius = cornerRadius
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = cornerRadius
    }
}
