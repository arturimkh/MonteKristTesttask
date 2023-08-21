//
//  StarWarsTableView.swift
//  MonteKristTest
//
//  Created by Artur Imanbaev on 08.08.2023.
//

import Foundation
import UIKit
import RealmSwift
class StarWarsTableView: UITableView {
    var starPeopleInfo: [ResultOfPeople] = []
    var starShipsInfo:[ResultOfStarships] = []
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.dataSource = self
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.rowHeight = 500
        self.register(StarwarsTableViewCell.self, forCellReuseIdentifier: "CellPeople")
        self.register(StarShipsTableViewCell.self, forCellReuseIdentifier: "CellStarShips")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: delegets data Source methods
extension StarWarsTableView: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // One for people, one for starships
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return starPeopleInfo.count
        } else {
            return starShipsInfo.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        if indexPath.section == 0 {
            if let cell = dequeueReusableCell(withIdentifier: "CellPeople", for: indexPath) as? StarwarsTableViewCell{
                if ((RealmManager.shared.findItemByName(starPeopleInfo[indexPath.row].name)) != nil){
                cell.favouriteImageView.image = UIImage(systemName: "star.fill")
                } else{
                cell.favouriteImageView.image = UIImage(systemName: "star")
                }
                cell.selectionStyle = .none
                cell.callBack = {[weak self] in
                    DispatchQueue.main.async {
                        self?.reloadData()
                    }
                }
                let person = starPeopleInfo[indexPath.row]
            
                cell.starTitle.text = person.name
                cell.configureItem(with: person)
                return cell
            }
        } else {
            if let cell = dequeueReusableCell(withIdentifier: "CellStarShips", for: indexPath) as? StarShipsTableViewCell{
                if ((RealmManager.shared.findItemByName(starShipsInfo[indexPath.row].name)) != nil){
                cell.favouriteImageView.image = UIImage(systemName: "star.fill")
                } else{
                cell.favouriteImageView.image = UIImage(systemName: "star")
                }
                cell.selectionStyle = .none
                cell.callBack = {[weak self] in
                    DispatchQueue.main.async {
                        self?.reloadData()
                    }
                }
                let starShip = starShipsInfo[indexPath.row]
            
                cell.starTitle.text = starShip.name
                cell.configureItem(with: starShip)
            return cell
            }
        }
        return UITableViewCell()
    }
}
