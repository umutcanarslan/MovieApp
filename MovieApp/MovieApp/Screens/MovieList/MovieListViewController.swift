//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Umut Can Arslan on 6.11.2022.
//

import UIKit

class MovieListViewController: UIViewController {

    private let searchBar = UISearchBar()
    private let tableView = UITableView()

    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSearchBar()
        configureTableView()
    }

    func configureSearchBar() {
        navigationItem.titleView = searchBar
        searchBar.delegate = self
    }

    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        // register cell
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

}

// MARK: - SearchBar Delegate
extension MovieListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
            // TODO: fetch movie response on viewmodel
        })
    }
}

// MARK: - TableView Delegate & Data Source
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return .init()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
}
