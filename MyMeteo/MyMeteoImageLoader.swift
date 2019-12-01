//
//  MyMeteoImageLoader.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 01/12/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Kingfisher

/// sourcery: AutoMockable
public protocol ImageLoader: class {
    func loadImage(imageView: UIImageView, url: URL?)
    func loadImage(imageView: UIImageView, url: URL?, placeholder: UIImage?)
    func loadImage(imageView: UIImageView, url: URL?, placeholder: UIImage?, animated: Bool)
}

extension ImageLoader {

    public func loadImage(imageView: UIImageView, url: URL?) {
        loadImage(imageView: imageView, url: url, placeholder: nil)
    }

    public func loadImage(imageView: UIImageView, url: URL?, placeholder: UIImage?) {
        loadImage(imageView: imageView, url: url, placeholder: placeholder, animated: false)
    }
}

public final class MyMeteoImageLoader {}

extension MyMeteoImageLoader: ImageLoader {

    public func loadImage(imageView: UIImageView, url: URL?, placeholder: UIImage?, animated: Bool) {
        imageView.kf.setImage(with: url, placeholder: placeholder, options: animated ? [.transition(ImageTransition.fade(1))] : nil)
    }
}

