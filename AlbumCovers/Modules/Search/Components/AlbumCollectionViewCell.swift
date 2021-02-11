//
//  AlbumCollectionViewCell.swift
//  AlbumCovers
//
//  Created by Роман Мироненко on 08.02.2021.
//

import UIKit
import Kingfisher

extension SearchCollectionViewCell {
    final class Album: UICollectionViewCell {
        
        let imageAlbum = setup(UIImageView()) {
            $0.contentMode = .scaleAspectFit
        }
        
        let nameLabel = setup(UILabel()) {
            $0.numberOfLines = 0
            $0.textAlignment = .center
            $0.adjustsFontSizeToFitWidth = true
            $0.minimumScaleFactor = 0.5
        }
        
        override init(frame: CGRect) {
            super.init(frame: .zero)
            backgroundColor = .lightGray
            contentView.addSubview(imageAlbum)
            contentView.addSubview(nameLabel)
            layer.cornerRadius = 10
            setupConstraints()
        }
        
        var imageURL: String?
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setupConstraints() {
            imageAlbum.snp.makeConstraints {
                $0.leading.trailing.top.equalToSuperview().inset(contentView.layoutMargins)
            }
            nameLabel.snp.makeConstraints {
                $0.top.equalTo(imageAlbum.snp.bottom).offset(16)
                $0.leading.trailing.equalToSuperview().inset(16)
                $0.height.equalTo(50)
                $0.bottom.equalToSuperview().inset(16)
            }
        }
    }
}
