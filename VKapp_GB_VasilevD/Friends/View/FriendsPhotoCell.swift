//
//  FriendsPhotoCell.swift
//  VKapp_GB_VasilevD
//
//  Created by Денис Васильев on 29/10/2019.
//  Copyright © 2019 Denis Vasilev. All rights reserved.
//

import UIKit
import AlamofireImage

class FriendsPhotoCell: UICollectionViewCell {
    
    @IBOutlet var photoView: UIImageView!
    @IBOutlet var likeControl: LikeControl!
    
    // MARK: - Public API
    public func configureLikeControl(likes count: Int, isLikedByUser: Bool) {
        likeControl.configure(likes: count, isLikedByUser: isLikedByUser)
    }
    
    public func configure(with photo: Photo) {
        let friendPhotoUrlString = photo.photoUrl
        photoView.af.setImage(withURL: URL(string: friendPhotoUrlString)!)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoView.image = nil 
    }
    
}
