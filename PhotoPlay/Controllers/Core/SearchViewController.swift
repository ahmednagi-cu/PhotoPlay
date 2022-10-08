//
//  SearchViewController.swift
//  PhotoPlay
//
//  Created by ahmed nagi on 29/09/2022.
//

import UIKit

class SearchViewController: UIViewController {
// MARK: - Properties
    private var titles : [Title] = [Title]()
    private let discoverTable : UITableView = {
        let table = UITableView()
        table.register(UpcomingTableViewCell.self, forCellReuseIdentifier: UpcomingTableViewCell.identifier)
        return table
    }()
    private let searchController : UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultViewController())
        controller.searchBar.placeholder = "Search for a Movie or a Tv show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchDiscoverMovies()
        configureTableView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }

// MARK: - Helper Functions
    public func setupUI(){
        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        navigationController?.navigationBar.tintColor = .white 
    }
    public func configureTableView(){
        view.addSubview(discoverTable)
        discoverTable.delegate = self
        discoverTable.dataSource = self
    }
// MARK: - API
    private func fetchDiscoverMovies(){
        APICaller.shared.getDiscoverMovies{ [weak self] result in
            switch result {
            case .success(let titles) :
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.discoverTable.reloadData()
                }
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
}

extension SearchViewController : table_datasource_delegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifier, for: indexPath) as? UpcomingTableViewCell else {
            return UITableViewCell()
        }
        let title = titles[indexPath.row]
        let model = TitleViewModel(titleName: title.original_name ?? title.original_title ?? "Unknow", posterURL: title.poster_path ?? "")
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else { return }
        
        APICaller.shared.getMovie(with: titleName) { [weak self] result in
            switch result {
            case .success(let videoelement):
                DispatchQueue.main.async {
                    let vc = PreviewViewController()
                    vc.configure(with: PreviewViewModel(title: titleName, youtubeView: videoelement, titleOverview: title.overview ?? ""))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension SearchViewController : UISearchResultsUpdating, SearchResultViewControllerDelegate {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultController = searchController.searchResultsController as? SearchResultViewController else {
                  return
              }
        resultController.delegate = self
        APICaller.shared.getSearchMovies(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles) :
                    resultController.titles = titles
                    resultController.searchResultCollectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func searchResultViewControllerDidTapItem(_ viewModel: PreviewViewModel) {
        DispatchQueue.main.sync { [weak self ] in
            let vc = PreviewViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
