//
//  HistoryTableViewCell.swift
//  AlbumCovers
//
//  Created by Роман Мироненко on 10.02.2021.
//

import UIKit
import SnapKit

extension HistoryViewController {
    class Cell: UITableViewCell {
        
        let titleLabel = setup(UILabel()) {
            $0.font = UIFont.boldSystemFont(ofSize: 18)
        }
        
        let deleteButton = setup(UIButton()) {
//            $0.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
            $0.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
            $0.tintColor = .red
        }
        
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            contentView.addSubview(titleLabel)
            contentView.addSubview(deleteButton)
            setupConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
        @objc func deleteButtonTapped() {
//            delegate?.didTapDeleteButton(self)
        }
        
        func setupConstraints() {
            
            titleLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(16)
                $0.centerY.equalToSuperview()
            }
            
            deleteButton.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(16)
                $0.centerY.equalToSuperview()
            }
        }
        
        func set(with title: String) {
            self.titleLabel.text = title
        }
        
    }
}
