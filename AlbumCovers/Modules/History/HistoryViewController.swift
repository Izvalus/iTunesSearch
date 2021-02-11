//
//  HistoryViewController.swift
//  AlbumCovers
//
//  Created by Роман Мироненко on 07.02.2021.
//

import UIKit
import RealmSwift

protocol HistoryViewControllerDelegate: AnyObject {
    func setSearch(search: String)
}

final class HistoryViewController: UIViewController {
        
    private lazy var customView = View()
    
    private let realm = try! Realm()
    
    var searchList: Results<SearchedRecently> {
        get {
            return realm.objects(SearchedRecently.self)
        }
    }
    
    weak var delegate: HistoryViewControllerDelegate?
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "History"
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    private func reloadData() {
        customView.tableView.reloadData()
    }
    
    private func deleteElement(number: Int) {
        let item = searchList.reversed()[number]
        try! realm.write {
            realm.delete(item)
        }
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: Cell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.titleLabel.text = searchList.reversed()[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.setSearch(search: searchList.reversed()[indexPath.row].name)
        tabBarController?.selectedIndex = 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteElement(number: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
}
