//
//  MainTabBarFactory.swift
//  AlbumCovers
//
//  Created by Роман Мироненко on 08.02.2021.
//

import UIKit

class MainTabBarFactory {
    
    func create() -> UIViewController {
        
        let searchController = SearchViewController()
        let searchItem = MainTabBar.Item(
            controller: UINavigationController(rootViewController: searchController).setPrefersLargeTitles(),
            title: "Search",
            systemItem: .search
        )
        
        let historyViewController = HistoryViewController()
        let historyItem = MainTabBar.Item(
            controller: UINavigationController(rootViewController: historyViewController).setPrefersLargeTitles(),
            title: "History",
            systemItem: .bookmarks
        )
        historyViewController.delegate = searchController
        
        let mainTabBar = MainTabBar(items: [searchItem, historyItem])
        return mainTabBar
    }
    
}

extension UINavigationController {
    func setPrefersLargeTitles(_ value: Bool = true) -> Self {
        navigationBar.prefersLargeTitles = true
        return self
    }
}
