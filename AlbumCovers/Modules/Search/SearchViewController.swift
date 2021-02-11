//
//  ViewController.swift
//  AlbumCovers
//
//  Created by Роман Мироненко on 07.02.2021.
//

import UIKit
import Kingfisher
import RealmSwift

final class SearchViewController: UIViewController, HistoryViewControllerDelegate {
    
    private lazy var customView = View()
    
    private let networkProvider = NetworkProvider()
    
    private let realm = try! Realm()

    private var albums = [Album]()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.collectionView.delegate = self
        customView.collectionView.dataSource = self
        navigationItem.title = "Search"
                
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    func setSearch(search: String) {
        searchController.searchBar.text = search
        searchBarSearchButtonClicked(searchController.searchBar)
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SearchCollectionViewCell.Album = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        let album = albums[indexPath.row]
        cell.nameLabel.text = album.collectionName
        
        cell.imageAlbum.kf.cancelDownloadTask()
        if let imageURL = URL(string: album.artworkUrl100) {
            cell.imageURL = album.artworkUrl100
            cell.imageAlbum.kf.setImage(
                with: imageURL,
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .cacheOriginalImage
                ]
            ) { result in
                if cell.imageURL != album.artworkUrl100 {
                    cell.imageAlbum.image = nil
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let album = albums[indexPath.row]
        let navigation = UINavigationController(rootViewController: DetailedInformationViewController(album: album))
        present(navigation, animated: true)
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let album = searchBar.text,
              album.isEmpty == false else { return }

        let search = SearchedRecently()
        search.name = album
        
        try? self.realm.write {
            self.realm.add(search)
        }
        
        let encodeURL = album.replacingOccurrences(of: " ", with: "+")
        networkProvider.fetchData(album: encodeURL) { [weak self] result in
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    self?.albums = value.results.sorted(by: { $0.collectionName < $1.collectionName })
                    self?.customView.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        albums.removeAll()
        customView.collectionView.reloadData()
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: collectionView.frame.width / 2 - 32, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}
