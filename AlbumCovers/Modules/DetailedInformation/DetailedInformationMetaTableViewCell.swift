//
//  DetailedInformationMetaTableViewCell.swift
//  AlbumCovers
//
//  Created by Роман Мироненко on 08.02.2021.
//

import UIKit

final class DetailedInformationMetaTableViewCell: UITableViewCell {
    
    let imageAlbum = setup(UIImageView()) {
        $0.contentMode = .scaleAspectFill
    }
    
    let titleLabel = setup(UILabel()) {
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
    }
    
    let atristLabel = setup(UILabel()) {
        $0.numberOfLines = 1
        $0.textAlignment = .center
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        contentView.addSubview(imageAlbum)
        contentView.addSubview(titleLabel)
        contentView.addSubview(atristLabel)
        
        imageAlbum.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(200)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageAlbum.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
        atristLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(16)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}
