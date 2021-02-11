//
//  DetailedInformationTableViewCell.swift
//  AlbumCovers
//
//  Created by Роман Мироненко on 08.02.2021.
//

import UIKit
import SnapKit

extension DetailedInformationViewController {
    final class DetailedInformationTableViewCell: UITableViewCell {
        
        let numberLabel = setup(UILabel()) {
            $0.numberOfLines = 0
        }
        
        let infoLabel = setup(UILabel()) {
            $0.numberOfLines = 1
        }
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            contentView.addSubview(numberLabel)
            contentView.addSubview(infoLabel)
            setupConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setupConstraints() {
            numberLabel.snp.makeConstraints {
                $0.leading.equalTo(layoutMarginsGuide)
                $0.width.equalTo(20)
                $0.centerY.equalToSuperview()
            }
            
            infoLabel.snp.makeConstraints {
                $0.leading.equalTo(numberLabel.snp.trailing).offset(16)
                $0.trailing.equalToSuperview().inset(contentView.layoutMargins.right)
                $0.centerY.equalToSuperview()
            }
        }
    }
}
