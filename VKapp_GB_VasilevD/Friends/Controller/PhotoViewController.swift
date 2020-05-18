//
//  PhotoViewController.swift
//  VKapp_GB_VasilevD
//
//  Created by Денис Васильев on 23/11/2019.
//  Copyright © 2019 Denis Vasilev. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoViewController: UIViewController {
    enum AnimationDirection {
        case left
        case right
    }
    
    @IBOutlet var bigPhotoImageView: UIImageView! {
        didSet {
            bigPhotoImageView.isUserInteractionEnabled = true
        }
    }
    
    private let additionalImageView = UIImageView()
    
    public var photos = [Photo]()
    public var selectedPhotoIndex: Int = 0
    private var propertyAnimator: UIViewPropertyAnimator!
    private var animationDirection: AnimationDirection = .left

    override func viewDidLoad() {
        super.viewDidLoad()

        guard !photos.isEmpty else { return }
        bigPhotoImageView.af.setImage(withURL: URL(string: photos[selectedPhotoIndex].photoUrl)!)
        
        let leftSwipeGR = UISwipeGestureRecognizer(target: self, action: #selector(photoSwipedLeft(_:)))
        leftSwipeGR.direction = .left
        bigPhotoImageView.addGestureRecognizer(leftSwipeGR)
        
        view.insertSubview(additionalImageView, belowSubview: bigPhotoImageView)
        additionalImageView.contentMode = .scaleAspectFit
        additionalImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            additionalImageView.leadingAnchor.constraint(equalTo: bigPhotoImageView.leadingAnchor),
            additionalImageView.trailingAnchor.constraint(equalTo: bigPhotoImageView.trailingAnchor),
            additionalImageView.topAnchor.constraint(equalTo: bigPhotoImageView.topAnchor),
            additionalImageView.bottomAnchor.constraint(equalTo: bigPhotoImageView.bottomAnchor)
        ])
        
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        view.addGestureRecognizer(panGR)
    }
    
    @objc func photoSwipedLeft(_ swipeGestureRecognizer: UISwipeGestureRecognizer) {
        guard selectedPhotoIndex + 1 <= photos.count - 1 else { return }
        
        additionalImageView.transform = CGAffineTransform(translationX: 1.3*self.additionalImageView.bounds.width, y: 150).concatenating(CGAffineTransform(scaleX: 1.3, y: 1.3))
        additionalImageView.af.setImage(withURL: URL(string: photos[selectedPhotoIndex + 1].photoUrl)!)
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {
            self.bigPhotoImageView.transform = CGAffineTransform(translationX: -1.5*self.bigPhotoImageView.bounds.width, y: -100).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
            self.additionalImageView.transform = .identity
        }) { _ in
            self.selectedPhotoIndex += 1
            self.bigPhotoImageView.af.setImage(withURL: URL(string: self.photos[self.selectedPhotoIndex].photoUrl)!)
            self.bigPhotoImageView.transform = .identity
            self.additionalImageView.image = nil
        }
    }
        
    @IBAction func photoSwipedRight(_ sender: UISwipeGestureRecognizer) {
        guard selectedPhotoIndex >= 1 else { return }
        
        additionalImageView.transform = CGAffineTransform(translationX: -1.3*self.additionalImageView.bounds.width, y: 150).concatenating(CGAffineTransform(scaleX: 1.3, y: 1.3))
        additionalImageView.af.setImage(withURL: URL(string: photos[selectedPhotoIndex - 1].photoUrl)!)
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {
            self.bigPhotoImageView.transform = CGAffineTransform(translationX: 1.5*self.bigPhotoImageView.bounds.width, y: -100).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
            self.additionalImageView.transform = .identity
        }) { _ in
            self.selectedPhotoIndex -= 1
            self.bigPhotoImageView.af.setImage(withURL: URL(string: self.photos[self.selectedPhotoIndex].photoUrl)!)
            self.bigPhotoImageView.transform = .identity
            self.additionalImageView.image = nil
        }
    }
    
    @objc func viewPanned(_ panGestureRecognizer: UIPanGestureRecognizer){
        switch panGestureRecognizer.state {
        case .began:
            if panGestureRecognizer.translation(in: view).x > 0 {
                guard selectedPhotoIndex >= 1 else { return }
                animationDirection = .right
                // начальная трансформация
                additionalImageView.transform = CGAffineTransform(translationX: -1.3*self.additionalImageView.bounds.width, y: 150).concatenating(CGAffineTransform(scaleX: 1.3, y: 1.3))
                additionalImageView.af.setImage(withURL: URL(string: photos[selectedPhotoIndex - 1].photoUrl)!)
                // создаем аниматор для движения направо
                propertyAnimator = UIViewPropertyAnimator(duration: 0.7, curve: .easeInOut, animations: {
                    self.bigPhotoImageView.transform = CGAffineTransform(translationX: 1.5*self.bigPhotoImageView.bounds.width, y: -100).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                    self.additionalImageView.transform = .identity
                })
                propertyAnimator.addCompletion { position in
                    switch position {
                    case .start:
                        self.additionalImageView.transform = CGAffineTransform(translationX: -1.3*self.additionalImageView.bounds.width, y: 150).concatenating(CGAffineTransform(scaleX: 1.3, y: 1.3))
                    case .end:
                        self.selectedPhotoIndex -= 1
                        self.bigPhotoImageView.af.setImage(withURL: URL(string: self.photos[self.selectedPhotoIndex].photoUrl)!)
                        self.bigPhotoImageView.transform = .identity
                        self.additionalImageView.image = nil
                    case .current:
                        break
                    @unknown default:
                        break
                    }
                }
            } else {
                guard selectedPhotoIndex + 1 <= photos.count - 1 else { return }
                animationDirection = .left
                // начальная трансформация
                additionalImageView.transform = CGAffineTransform(translationX: 1.3*self.additionalImageView.bounds.width, y: 150).concatenating(CGAffineTransform(scaleX: 1.3, y: 1.3))
                additionalImageView.af.setImage(withURL: URL(string: photos[selectedPhotoIndex + 1].photoUrl)!)
                // создаем аниматор для движения налево
                propertyAnimator = UIViewPropertyAnimator(duration: 0.7, curve: .easeInOut, animations: {
                    self.bigPhotoImageView.transform = CGAffineTransform(translationX: -1.5*self.bigPhotoImageView.bounds.width, y: -100).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                    self.additionalImageView.transform = .identity
                })
                propertyAnimator.addCompletion { position in
                    switch position {
                    case .start:
                        self.additionalImageView.transform = CGAffineTransform(translationX: 1.3*self.additionalImageView.bounds.width, y: 150).concatenating(CGAffineTransform(scaleX: 1.3, y: 1.3))
                    case .end:
                        self.selectedPhotoIndex += 1
                        self.bigPhotoImageView.af.setImage(withURL: URL(string: self.photos[self.selectedPhotoIndex].photoUrl)!)
                        self.bigPhotoImageView.transform = .identity
                        self.additionalImageView.image = nil
                    case .current:
                        break
                    @unknown default:
                        break
                    }
                }
            }
        case .changed:
            guard let propertyAnimator = self.propertyAnimator else { return }
            switch animationDirection {
            case .right:
                let percent = min(max(0, panGestureRecognizer.translation(in: view).x / 200), 1)
                propertyAnimator.fractionComplete = percent
            case .left:
                let percent = min(max(0, -panGestureRecognizer.translation(in: view).x / 200), 1)
                propertyAnimator.fractionComplete = percent
            }
        case .ended:
            if propertyAnimator.fractionComplete > 0.33 {
                propertyAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0.5)
            } else {
                propertyAnimator.isReversed = true
                propertyAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0.5)
            }
        default:
            break
        }
    }
}
