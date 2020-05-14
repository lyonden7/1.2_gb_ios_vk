//
//  LoadingIndicator.swift
//  VKapp_GB_VasilevD
//
//  Created by Денис Васильев on 19/11/2019.
//  Copyright © 2019 Denis Vasilev. All rights reserved.
//

import UIKit

class LoadingIndicator: UIView {
    
    @IBOutlet var leftLoadingItemView: UIView?
    @IBOutlet var centerLoadingItemView: UIView?
    @IBOutlet var rightLoadingItemView: UIView?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        leftLoadingItemView?.backgroundColor = .white
        centerLoadingItemView?.backgroundColor = .white
        rightLoadingItemView?.backgroundColor = .white
        
        leftLoadingItemView!.layer.cornerRadius = bounds.height/2
        centerLoadingItemView!.layer.cornerRadius = bounds.height/2
        rightLoadingItemView!.layer.cornerRadius = bounds.height/2
    }

}
