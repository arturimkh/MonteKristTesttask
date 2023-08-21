import RealmSwift
import Foundation
import UIKit

class RealmManager {
    static let shared = RealmManager()

    private init() {}

    func addToFavoritesPeople(titlePeople: [String]) {
        do {
            let realm = try Realm()
            try realm.write {
                let newItem = People()
                newItem.name = titlePeople[0]
                newItem.height = titlePeople[1]
                newItem.mass = titlePeople[2]
                newItem.hairColor = titlePeople[3]
                newItem.skinColor = titlePeople[4]
                newItem.eyeColor = titlePeople[5]
                newItem.gender = titlePeople[6]
                newItem.isFavorite = true
                realm.add(newItem)
            }
        } catch {
            print("Ошибка при добавлении в избранное: \(error)")
        }
    }


    func removeFromFavorites(name: String) {
        do {
            let realm = try Realm()
            if let item = realm.objects(People.self).filter("name == %@", name).first {
                try realm.write {
                    item.isFavorite = false
                    realm.delete(item)
                }
            }
        } catch {
            print("Ошибка при удалении из избранного: \(error)")
        }
    }

    func fetchFavoriteItems() -> Results<People>? {
        do {
            let realm = try Realm()
            return realm.objects(People.self).filter("isFavorite == true")
        } catch {
            print("Ошибка при запросе избранных элементов: \(error)")
            return nil
        }
    }
    func findItemByName(_ name: String) -> People? {
        do {
            let realm = try Realm()
            return realm.objects(People.self).filter("name == %@", name).first
        } catch {
            print("Ошибка при поиске элемента по имени: \(error)")
            return nil
        }
    }
}
