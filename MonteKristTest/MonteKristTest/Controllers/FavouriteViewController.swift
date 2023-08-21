//
//  ViewController.swift
//  MonteKristTest
//
//  Created by Artur Imanbaev on 07.08.2023.
//

import UIKit
import RealmSwift
class FavouriteViewController:UIViewController, UISearchBarDelegate{
    
    let starWarsTable = StarWarsTableView()
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        starWarsTable.register(StarwarsTableViewCell.self, forCellReuseIdentifier: "CellPeople")
        starWarsTable.register(StarShipsTableViewCell.self, forCellReuseIdentifier: "CellStarShips")
        setUI()
        configureNavigation()
    }
    
    func getData(){
        let items = RealmManager.shared.fetchFavoriteItems()
        starWarsTable.starPeopleInfo = fromItemsToPeople(from: items!)
        //starWarsTable.starShipsInfo = fromItemsToStarShips(from: items!)
        DispatchQueue.main.async {
            self.starWarsTable.reloadData()
        }
    }
    func fromItemsToPeople(from items: Results<People>) -> [ResultOfPeople] {
        var people: [ResultOfPeople] = []
        for item in items {
            let person = ResultOfPeople(
                name: item.name,
                height: item.height,
                mass: item.mass,
                hairColor: item.hairColor,
                skinColor: item.skinColor,
                eyeColor: item.eyeColor,
                gender: item.gender
            )
            people.append(person)
        }
        return people
    }
    func fromItemsToStarShips(from starships: Results<StarShips>) -> [ResultOfStarships] {
        var results: [ResultOfStarships] = []
        for starship in starships {
            let result = ResultOfStarships(
                name: starship.name,
                model: starship.model,
                manufacturer: starship.manufacturer,
                length: starship.lenght,
                crew: starship.crew,
                passengers: starship.passengers,
                consumables: starship.consumables
            )
            results.append(result)
        }
        return results
    }
    func configureNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Favourite"
        navigationItem.hidesSearchBarWhenScrolling = false
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
