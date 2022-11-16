//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Umut Can Arslan on 6.11.2022.
//

import UIKit

private typealias movieCell = MovieListTableViewCell

final class MovieListViewController: UIViewController {

    private let viewModel = MovieListViewModel()

    private let searchBar = UISearchBar()
    private let tableView = UITableView()

    var activityIndicator = UIActivityIndicatorView()
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.listState = viewModelObserve
        configureActivityIndicator()
        configureSearchBar()
        configureTableView()
    }

    func configureActivityIndicator() {
        activityIndicator.style = .large
        activityIndicator.tintColor = UIColor(red: 94/255, green: 171/255, blue: 189/255, alpha:1)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    func configureSearchBar() {
        navigationItem.titleView = searchBar
        searchBar.delegate = self
    }

    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(movieCell.getXib(), forCellReuseIdentifier: movieCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func viewModelObserve(change: MovieListViewModelState.MovieListStateChange) {
        viewModel.listState = { [weak self] state in
            switch state {
            case .idle:
                break
            case .loading(let isLoading):
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            case .success:
                self?.reloadTable()
            case .error(let error):
                self?.reloadTable()
                self?.showAlert(title: "Error", message: error.rawValue)
            }
        }

    }

    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

// MARK: - SearchBar Delegate
extension MovieListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
            self.viewModel.getMovieList(with: searchText)
        })
    }
}

// MARK: - TableView Delegate & Data Source
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: movieCell.reuseIdentifier,
            for: indexPath
        ) as? movieCell else { return .init()}
        cell.setupCell(with: viewModel.state.movies[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.state.movies.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let imdbID = viewModel.state.movies[indexPath.row].imdbID else { return }
        let viewModel = MovieDetailViewModel(imdbID: imdbID)
        let viewController = MovieDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
