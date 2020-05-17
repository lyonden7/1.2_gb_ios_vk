//
//  FriendsPhotoController.swift
//  VKapp_GB_VasilevD
//
//  Created by Денис Васильев on 23/10/2019.
//  Copyright © 2019 Denis Vasilev. All rights reserved.
//

import UIKit

class FriendsPhotoController: UICollectionViewController {
    
    let networkService = NetworkService()
    let token = Session.instance.accessToken
    
    var photos = [UIImage]()
    
    var friend: User!

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(friend != nil)

        title = "\(friend.firstName) \(friend.lastName)"
        
        networkService.loadFriendPhotos(token: token)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsPhotoCell", for: indexPath) as! FriendsPhotoCell
        
        cell.photoView.image = photos[indexPath.item]
        
        let count = Int.random(in: 5...500)
        let isLiked = Bool.random()
        cell.configureLikeControl(likes: count, isLikedByUser: isLiked)
        
        return cell
    }
}

extension FriendsPhotoController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width / 3).rounded(.down)
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension FriendsPhotoController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Big Photo",
            let selectedPhotoIndexPath = collectionView.indexPathsForSelectedItems?.first,
            let bigPhotoVC = segue.destination as? PhotoViewController {
            bigPhotoVC.photos = photos
            bigPhotoVC.selectedPhotoIndex = selectedPhotoIndexPath.item
            collectionView.deselectItem(at: selectedPhotoIndexPath, animated: true)
        }
    }
}


