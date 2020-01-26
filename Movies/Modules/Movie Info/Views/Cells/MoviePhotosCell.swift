//
//  MoviePhotosCell.swift
//  Movies
//
//  Created by Islam on 1/25/20.
//  Copyright © 2020 App Lineup. All rights reserved.
//

import UIKit
import Nuke

class MoviePhotosCell: UITableViewCell {

    var photos: [Photo] = []
    @IBOutlet var moviePhotosCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(photos: [Photo]) {
        self.photos = photos
        moviePhotosCollectionView.reloadData()
    }
}

private extension MoviePhotosCell {
    func setup() {
        let identifier = String(describing: PhotoCell.self)
        let nib = UINib(nibName: identifier, bundle: nil)
        moviePhotosCollectionView.register(nib, forCellWithReuseIdentifier: identifier)
        moviePhotosCollectionView.dataSource = self
        moviePhotosCollectionView.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(detectOrientation),
                                               name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    @objc func detectOrientation() {
       moviePhotosCollectionView.collectionViewLayout.invalidateLayout()
    }
}

extension MoviePhotosCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = String(describing: PhotoCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PhotoCell

        let selectedImage = self.photos[indexPath.row]
        let url = "http://farm\(selectedImage.farm).static.flickr.com/\(selectedImage.server)/\(selectedImage.id)_\(selectedImage.secret).jpg"
        let imageURL = URL(string: url)!
        Nuke.loadImage(with: imageURL, into: cell.moviePhotoImageView)
        return cell
    }
}

extension MoviePhotosCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size: CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
}
