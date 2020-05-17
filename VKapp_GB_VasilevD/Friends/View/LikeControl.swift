//
//  LikeControl.swift
//  VKapp_GB_VasilevD
//
//  Created by Денис Васильев on 08/11/2019.
//  Copyright © 2019 Denis Vasilev. All rights reserved.
//

import UIKit

class LikeControl: UIControl {

    var count: Int = 0
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var likeImageView: UIImageView!
    
    public var isLiked: Bool = false {
        didSet {
            if !isLiked {
                likeImageView.image = UIImage(systemName: "heart.fill")
                likeImageView.tintColor = .red
                countLabel.textColor = .red
                setupGestureRecognizer()
                count += 1
                animationFlipFromLeft(countLabel, String(count))
//                countLabel?.text = String(count) - изменение лайков без анимации
            } else {
                likeImageView.image = UIImage(systemName: "heart")
                likeImageView.tintColor = .black
                countLabel.textColor = .black
                setupGestureRecognizer()
                count -= 1
                animationFlipCurlDown(countLabel, String(count))
//                countLabel?.text = String(count) - изменение лайков без анимации
            }
        }
    }
    
    // MARK: - Privates
    
    private func setupGestureRecognizer() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        tap.numberOfTouchesRequired = 1
        likeImageView.isUserInteractionEnabled = true
        likeImageView?.addGestureRecognizer(tap)
    }
    
    @objc private func tapped(_ tapGesture: UITapGestureRecognizer) {
        isLiked.toggle()
        setNeedsDisplay()
        sendActions(for: .valueChanged)
    }
    
    // MARK: - Public API
    public func configure(likes count: Int, isLikedByUser: Bool) {
        self.count = count
        self.isLiked = isLikedByUser
    }
    
    //MARK: - Animation

    func animationFlipFromLeft (_ label: UILabel, _ text: String) {
        UIView.transition(with: label,
                          duration: 0.5,
                          options: .transitionFlipFromLeft,
                          animations: {
                            label.text = text
        },
                          completion: nil)
    }
    
    func animationFlipCurlDown (_ label: UILabel, _ text: String) {
        UIView.transition(with: label,
                          duration: 0.5,
                          options: .transitionCurlDown,
                          animations: {
                            label.text = text
        },
                          completion: nil)
    }
    
    
}


