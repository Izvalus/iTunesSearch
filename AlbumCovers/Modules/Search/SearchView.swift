//
//  SearchView.swift
//  AlbumCovers
//
//  Created by Роман Мироненко on 07.02.2021.
//

import UIKit
import SnapKit

extension SearchViewController {
    final class View: UIView {
        
        lazy var collectionViewLayout = factoryLayout()
        
        lazy var collectionView = setup(UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)) {
            $0.register(registerClass: SearchCollectionViewCell.Album.self)
            $0.backgroundColor = .white
            $0.alwaysBounceVertical = true
        }
        
        init() {
            super.init(frame: .zero)
            addSubview(collectionView)
            backgroundColor = .lightGray
            setupConstraints()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func factoryLayout() -> UICollectionViewLayout {
            let flowLayout = UICollectionViewFlowLayout()
            return flowLayout
        }
        
        func setupConstraints() {
            collectionView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
}

