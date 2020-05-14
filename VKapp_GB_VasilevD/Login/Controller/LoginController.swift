//
//  LoginFormController.swift
//  VKapp_GB_VasilevD
//
//  Created by Денис Васильев on 19/10/2019.
//  Copyright © 2019 Denis Vasilev. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    
    // MARK: Outlets
    @IBOutlet var loginInputTextField: UITextField!
    @IBOutlet var passwordInputTextField: UITextField!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var loginLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var loadingIndicator: LoadingIndicator!
    
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingIndicator.backgroundColor = .none
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_ :)))
        self.view.addGestureRecognizer(recognizer)
        
        animateLoginPasswordLabelsAppearing()
        animateTitleLabelAppearing()
        animateTextFieldsAppearing()
        loadingAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    // MARK: IBAction
    @IBAction func loginButtonPressed(_ sender: Any) {
    }
    
    
    // MARK: Keyboard (objc)
    @objc func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification){
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }

    
    // MARK: Segue (Login, alert)
    

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let login = loginInputTextField.text!
        let password = passwordInputTextField.text!
    
        if login == "" && password == "" {
            print("Успешная авторизация")
            return true
        } else {
            print("Неуспешная авторизация")
            let alert = UIAlertController(title: "Ошибка", message: "Введены неверные данные пользователя,", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        
            return false
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginSegue" {
            loginInputTextField.text = ""
            passwordInputTextField.text = ""
        }
    }
    
    
    // MARK: - Labels animation, textfields animation, button animation
    
    func loadingAnimation() {
        
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       options: [.autoreverse, .repeat],
                       animations: {
                        self.loadingIndicator.leftLoadingItemView?.alpha = 0
        },
                       completion: nil)
        
        UIView.animate(withDuration: 0.7,
                       delay: 0.3,
                       options: [.autoreverse, .repeat],
                       animations: {
                        self.loadingIndicator.centerLoadingItemView?.alpha = 0
        },
                       completion: nil)
        
        UIView.animate(withDuration: 0.7,
                       delay: 0.6,
                       options: [.autoreverse, .repeat],
                       animations: {
                        self.loadingIndicator.rightLoadingItemView?.alpha = 0
        },
                       completion: nil)
        
    }
    
//    func animateLoginPasswordLabelsAppearing() {
//        let offset = view.bounds.width
//        loginLabel.transform = CGAffineTransform(translationX: -offset, y: 0)
//        passwordLabel.transform = CGAffineTransform(translationX: offset, y: 0)
//
//        UIView.animate(withDuration: 1,
//                       delay: 1,
//                       options: .curveEaseInOut,
//                       animations: {
//                        self.loginLabel.transform = .identity
//                        self.passwordLabel.transform = .identity
//        }, completion: nil)
//    }
    
        func animateLoginPasswordLabelsAppearing() {
            let offset = abs(self.loginLabel.frame.midY - self.passwordLabel.frame.midY)
            self.loginLabel.transform = CGAffineTransform(translationX: 0, y: offset)
            self.passwordLabel.transform = CGAffineTransform(translationX: 0, y: -offset)
            
            UIView.animateKeyframes(withDuration: 1,
                                    delay: 1,
                                    options: .calculationModePaced,
                                    animations: {
                                        UIView.addKeyframe(withRelativeStartTime: 0,
                                                           relativeDuration: 0.5,
                                                           animations: {
                                                            self.loginLabel.transform = CGAffineTransform(translationX: 150, y: 50)
                                                            self.passwordLabel.transform = CGAffineTransform(translationX: -150, y: -50)
                                        })
                                        UIView.addKeyframe(withRelativeStartTime: 0.5,
                                                           relativeDuration: 0.5,
                                                           animations: {
                                                            self.loginLabel.transform = .identity
                                                            self.passwordLabel.transform = .identity
                                        })
            },
                                    completion: nil)
    }
    
//    func animateTitleLabelAppearing() {
//        let offset = view.bounds.height/2
//        self.titleLabel.transform = CGAffineTransform(translationX: 0, y: -offset)
//
//        UIView.animate(withDuration: 1,
//                       delay: 1,
//                       usingSpringWithDamping: 0.5,
//                       initialSpringVelocity: 0,
//                       options: .curveEaseOut,
//                       animations: {
//                        self.titleLabel.transform = .identity
//        },
//                       completion: nil)
//    }
    
    func animateTitleLabelAppearing() {
        let offset = view.bounds.height/2
        self.titleLabel.transform = CGAffineTransform(translationX: 0, y: -offset)
        
        let animator = UIViewPropertyAnimator(duration: 1,
                                              dampingRatio: 0.5,
                                              animations: { self.titleLabel.transform = .identity })
        
        animator.startAnimation(afterDelay: 1)
    }
    
//    func animateTextFieldsAppearing() {
//        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
//        fadeInAnimation.fromValue = 0
//        fadeInAnimation.toValue = 1
//        fadeInAnimation.duration = 2
//        fadeInAnimation.beginTime = CACurrentMediaTime() + 1
//        fadeInAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
//        fadeInAnimation.fillMode = CAMediaTimingFillMode.backwards
//
//        self.loginInputTextField.layer.add(fadeInAnimation, forKey: nil)
//        self.passwordInputTextField.layer.add(fadeInAnimation, forKey: nil)
//    }
    
    func animateTextFieldsAppearing() {
        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.fromValue = 0
        fadeInAnimation.toValue = 1
        
        let scaleAnimation = CASpringAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 1
        scaleAnimation.stiffness = 150
        scaleAnimation.mass = 2
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 1
        animationGroup.beginTime = CACurrentMediaTime() + 1
        animationGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animationGroup.fillMode = CAMediaTimingFillMode.backwards
        animationGroup.animations = [fadeInAnimation, scaleAnimation]
        
        self.loginInputTextField.layer.add(animationGroup, forKey: nil)
        self.passwordInputTextField.layer.add(animationGroup, forKey: nil)
    }
    
    var interactiveAnimator: UIViewPropertyAnimator!
    
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            interactiveAnimator?.startAnimation()
            interactiveAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                         dampingRatio: 0.5,
                                                         animations: {
                                                            self.loginButton.transform = CGAffineTransform(translationX: 0, y: 150)
                                                            
            })
            interactiveAnimator.pauseAnimation()
        case .changed:
            let translation = recognizer.translation(in: self.view)
            interactiveAnimator.fractionComplete = translation.y / 100
        case .ended:
            interactiveAnimator.stopAnimation(true)
            interactiveAnimator.addAnimations {
                self.loginButton.transform = .identity
            }
            interactiveAnimator.startAnimation()
        default:
            return
        }
    }
    
//    func animateLoginButton() {
//        let animation = CASpringAnimation(keyPath: "transform.scale")
//        animation.fromValue = 0
//        animation.toValue = 1
//        animation.stiffness = 200
//        animation.mass = 2
//        animation.duration = 2
//        animation.beginTime = CACurrentMediaTime() + 1
//        animation.fillMode = CAMediaTimingFillMode.backwards
//
//        self.loginButton.layer.add(animation, forKey: nil)
//    }
    
}



    
    
    
 

