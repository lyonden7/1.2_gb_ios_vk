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
    
//    func setSize(with photoSizes: PhotoSizes, photo: Photo) {
//        guard let imageSize = photo.sizes.array?.first(where: { $0; photoSizes.type == "s" }) else { return })
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoView.image = nil 
    }
    
}

//            "sizes": [
//                {
//                    "type": "m", (o,p,q,r,s,w,x,y,z)


//    guard let imageSize = json["sizes"].array?.first(where: { $0["type"] == "s" }) else { return }
//    self.friendPhotoUrlString = imageSize["url"].stringValue
//
//    if let friendPhotoUrlString = json["sizes"].array?.first(where: { $0["type"] == "m" })?["url"].string {
//        self.friendPhotoUrlString = friendPhotoUrlString
//    }
//
//    self.friendPhotoFullSizeUrlString = self.friendPhotoUrlString
//
//    if let sizes = json["sizes"].array?
//        .filter({ ["m", "o", "p", "q", "r", "s", "w", "x", "y", "z"].contains($0["type"]) })
//        .sorted(by: { $0["width"].intValue * $0["height"].intValue > $1["width"].intValue * $1["height"].intValue }),
//        let photoUrlString = sizes.first?["url"].string {
//        self.friendPhotoFullSizeUrlString = photoUrlString
//    }
//}



//public func configure(with photo: Photo) {
//    let friendPhotoUrlString = photo.friendPhotoFullSizeUrlString
//    photoView.kf.setImage(with: URL(string: friendPhotoUrlString))
//}

