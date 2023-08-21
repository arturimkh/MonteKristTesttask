//
//  StarShipsTableViewCell.swift
//  MonteKristTest
//
//  Created by Artur Imanbaev on 09.08.2023.
//

import Foundation
import UIKit
class StarShipsTableViewCell: UITableViewCell {
    let infoArray: [String] = ["Name","Model","Manufacturer","Length","Crew","Passengers","Consumables"]
    var infoReplacebleLabels:[UILabel] = []
    var infoLabels:[UILabel] = []
    var callBack: (() -> ())?

    var starTitle: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Death Star"
        $0.numberOfLines = 2
        $0.font = .systemFont(ofSize: 20)
        return $0
    }(UILabel())
    let favouriteImageView: UIImageView = {
        $0.image = UIImage(systemName: "star")
        $0.tintColor = .lightGray
        $0.contentMode = .scaleAspectFill
        $0.isUserInteractionEnabled = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    func configureItem(with item: ResultOfStarships){
        infoReplacebleLabels[0].text = item.name
        infoReplacebleLabels[1].text = item.model
        infoReplacebleLabels[2].text = item.manufacturer
        infoReplacebleLabels[3].text = item.length
        infoReplacebleLabels[4].text = item.crew
        infoReplacebleLabels[5].text = item.passengers
        infoReplacebleLabels[6].text = item.consumables
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupUI()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gesture:)))
        favouriteImageView.addGestureRecognizer(tapGesture)
    }
    @objc
    private func imageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            let shipInfo = infoReplacebleLabels.map{$0.text ?? ""}
            let shipName = RealmManager.shared.findItemByName(shipInfo[0])?.name
            if(shipName == nil){
                RealmManager.shared.addToFavoritesPeople(titlePeople: shipInfo)
                favouriteImageView.image = UIImage(systemName: "star.fill")
            } else{
                RealmManager.shared.removeFromFavorites(name: shipName as! String)
                favouriteImageView.image = UIImage(systemName: "star")
            }
            callBack!() //если нажали на кнопку то обновляем везле табличку
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI(){
        self.contentView.addSubview(starTitle)
        NSLayoutConstraint.activate([
            starTitle.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            starTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15)
        ])
        self.contentView.addSubview(favouriteImageView)
        NSLayoutConstraint.activate([
            favouriteImageView.centerYAnchor.constraint(equalTo: starTitle.centerYAnchor),
            favouriteImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -15),
            favouriteImageView.heightAnchor.constraint(equalToConstant: 35),
            favouriteImageView.widthAnchor.constraint(equalToConstant: 35)
        ])
        
        //MARK: creating info labels
        for index in infoArray.indices{
            let info: UILabel = {
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.contentMode = .scaleAspectFit
                $0.tintColor = .black
                $0.font = .systemFont(ofSize: 20)
                $0.text = infoArray[index] + " :"
                return $0
            }(UILabel())
            let infoReplecable: UILabel = {
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.contentMode = .scaleAspectFit
                $0.tintColor = .black
                $0.font = .systemFont(ofSize: 20)
                $0.text = ""
                return $0
            }(UILabel())
            infoLabels.append(info)
            infoReplacebleLabels.append(infoReplecable)
            self.contentView.addSubview(info)
            NSLayoutConstraint.activate([
                info.topAnchor.constraint(equalTo: starTitle.bottomAnchor,constant: CGFloat(30 + (index*60))),
                info.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 30)
            ])
            self.contentView.addSubview(infoReplecable)
            NSLayoutConstraint.activate([
                infoReplecable.topAnchor.constraint(equalTo: starTitle.bottomAnchor,constant: CGFloat(30 + (index*60))),
                infoReplecable.leadingAnchor.constraint(equalTo: self.infoLabels[index].trailingAnchor, constant: 10)
            ])
        }
    }
}
