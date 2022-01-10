//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Joseph Conteh on 1/4/22.
//  Copyright © 2021 Ebay. All rights reserved.

import UIKit
import Combine

class SearchViewController: UIViewController {
    
    private let viewModel = SearchViewModel()
    private var subscribers = Set<AnyCancellable>()
    
    private var tableView: UITableView = UITableView()
    private var searchBar: UISearchBar = UISearchBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpBinding()
    }
    
    private func setUpUI() {
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        tableView.pinTable(view)
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 70).isActive = true
        searchBar.pinSearch(view)
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        tableView.rowHeight = 60
        title = "Movie Search"
        view.backgroundColor = .white
    }
    
    private func setUpBinding() {
        viewModel
            .$movies
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &subscribers)
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell
        else { return UITableViewCell() }
        var movie = viewModel.movies[indexPath.row]
        cell.configure(title: movie.originalTitle, releaseDate: movie.releaseDateMediumStyle, voteAverage: movie.voteAverage)
        return cell
    }
    
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectMovie(at: indexPath.row)
        let detailVC = MovieDetailViewController()
        detailVC.setSearchViewModel(viewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(by: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
