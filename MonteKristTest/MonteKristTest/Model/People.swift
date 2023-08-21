import RealmSwift
import Foundation
class People: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var height = ""
    @objc dynamic var mass = ""
    @objc dynamic var hairColor = ""
    @objc dynamic var skinColor = ""
    @objc dynamic var eyeColor = ""
    @objc dynamic var birthYear = ""
    @objc dynamic var gender = ""
    @objc dynamic var isFavorite = false

    override static func primaryKey() -> String? {
        return "id"
    }
}
class StarShips: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var model = ""
    @objc dynamic var mass = ""
    @objc dynamic var manufacturer = ""
    @objc dynamic var lenght = ""
    @objc dynamic var crew = ""
    @objc dynamic var passengers = ""
    @objc dynamic var consumables = ""
    @objc dynamic var isFavorite = false

    override static func primaryKey() -> String? {
        return "id"
    }
}
