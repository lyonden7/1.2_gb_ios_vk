//
//  AvatarView.swift
//  VKapp_GB_VasilevD
//
//  Created by Денис Васильев on 05/11/2019.
//  Copyright © 2019 Denis Vasilev. All rights reserved.
//

import UIKit

class AvatarView: UIView {

    @IBOutlet var userAvatarView: UIImageView!
    @IBOutlet var shadowView: UIView!
    
    @IBInspectable var shadowColor: UIColor = .black { didSet { setNeedsDisplay() } }
    @IBInspectable var shadowRadius: CGFloat = 8 { didSet { setNeedsDisplay() } }
    @IBInspectable var shadowOpacity: Float = 1 { didSet { setNeedsDisplay() } }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //        shadowView.clipsToBounds = false  -  вызывается для UIView
        shadowView.layer.masksToBounds = false   // вызывается для слоя
        shadowView.backgroundColor = .white
        shadowView.layer.shadowColor = shadowColor.cgColor
        shadowView.layer.shadowOpacity = shadowOpacity
        shadowView.layer.shadowRadius = shadowRadius
        shadowView.layer.shadowOffset = CGSize.zero
        
        //        userAvatarView.clipsToBounds = true
        userAvatarView.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shadowView.layer.cornerRadius = bounds.width/2
        userAvatarView.layer.cornerRadius = bounds.width/2
    }

}
