//
//  DetailedInformationView.swift
//  AlbumCovers
//
//  Created by Роман Мироненко on 08.02.2021.
//

import UIKit
import SnapKit

extension DetailedInformationViewController {
    class DetailedInformationView: UIView {
        
        
        lazy var tableView = setup(UITableView()) {
            $0.tableFooterView = UIView()
            $0.register(registerClass: DetailedInformationTableViewCell.self)
            $0.register(registerClass: DetailedInformationMetaTableViewCell.self)
        }
        
        init() {
            super.init(frame: .zero)
            addSubview(tableView)
            backgroundColor = .white
            setupConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setupConstraints() {
            tableView.snp.makeConstraints {
                $0.edges.equalTo(safeAreaLayoutGuide)
            }
        }
    }
}
