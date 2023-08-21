//
//  ViewController.swift
//  MonteKristTest
//
//  Created by Artur Imanbaev on 07.08.2023.
//

import UIKit
import RealmSwift
class ViewController:UIViewController, UISearchBarDelegate{
    
    let starWarsTable = StarWarsTableView()
    let searchController = UISearchController()
    override func viewWillAppear(_ animated: Bool) {
        starWarsTable.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        starWarsTable.register(StarwarsTableViewCell.self, forCellReuseIdentifier: "CellPeople")
        starWarsTable.register(StarShipsTableViewCell.self, forCellReuseIdentifier: "CellStarShips")
        setUI()
        configureNavigation()
        configureSearchController()
    }
    
    func configureNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    func configureSearchController() {
        let image = UIImage(systemName: "slider.horizontal.3")
        searchController.searchBar.setImage(image, for: .bookmark, state: .normal)
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Enter the person or starship"
        definesPresentationContext = true
    }
    private func setUI(){
        view.addSubview(starWarsTable)
        NSLayoutConstraint.activate([
            starWarsTable.topAnchor.constraint(equalTo: view.topAnchor),
            starWarsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            starWarsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            starWarsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),

        ])
    }
}
// MARK: - UISearchResultsUpdating
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        let urlOfPeople = URL(string: "https://swapi.dev/api/people/?search=\(searchText)")
        let urlOfStarships = URL(string: "https://swapi.dev/api/starships/?search=\(searchText)")
        APICaller.shared.request(url: urlOfPeople, expecting: TitleOfPeople.self) { [weak self] result in
            switch result{
            case .success(let info):
                self?.starWarsTable.starPeopleInfo = info.results
                DispatchQueue.main.async{
                    self?.starWarsTable.reloadData()
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        APICaller.shared.request(url: urlOfStarships, expecting: TitleStarships.self) { [weak self] result in
            switch result{
            case .success(let info):
                self?.starWarsTable.starShipsInfo = info.results
                DispatchQueue.main.async {
                    self?.starWarsTable.reloadData()
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
