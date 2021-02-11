//
//  DetailedInformationViewController.swift
//  AlbumCovers
//
//  Created by Роман Мироненко on 08.02.2021.
//

import UIKit
import Kingfisher

final class DetailedInformationViewController: UIViewController {
    
    enum CellStyle {
        case meta(Album)
        case song(String, Int)
    }
    
    private lazy var customView = DetailedInformationView()
    
    private let networkProvider = NetworkProvider()
    
    private let album: Album
    
    var cells = [CellStyle]()
    
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Close",
            style: .plain,
            target: self,
            action: #selector(close)
        )
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        songRequest()
    }
    
    @objc
    private func close() {
        dismiss(animated: true)
    }
    
    private func songRequest() {
        networkProvider.fetchSongs(albumID: "\(album.collectionId)") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let songs):
                DispatchQueue.main.async {
                    self.cells = [.meta(self.album)] + songs.results.enumerated().compactMap {
                        guard let trackName = $0.element.trackName,
                              trackName.isEmpty == false else { return nil }
                        return CellStyle.song(trackName, $0.offset)
                    }
                    self.customView.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupImage(imageView: UIImageView, path: String) {
        guard let imageURL = URL(string: path) else { return }
        let processor = RoundCornerImageProcessor(cornerRadius: 8)
        imageView.kf.setImage(
            with: imageURL,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ]
        )
    }
    
}

extension DetailedInformationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cells[indexPath.row] {
        case let .meta(meta):
            let cell: DetailedInformationMetaTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            setupImage(imageView: cell.imageAlbum, path: meta.artworkUrl100)
            cell.titleLabel.text = meta.collectionName
            cell.atristLabel.text = meta.artistName
            return cell
        case let .song(name, index):
            let cell: DetailedInformationTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.numberLabel.text = "\(index)"
            cell.infoLabel.text = name
            return cell
        }
    }
    
    
}



