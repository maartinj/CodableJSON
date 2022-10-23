/*:
 [< Previous](@previous)           [Home](Introduction)

 ## Encoding Data
Encoding data is the opposite of Decoding. In this section we will look at how you can encode your data into JSON

*/
/*:
 ## Basic
 */
import UIKit

struct Person: Codable {
    var name: String
    var age: Int
    var gender: String
    var partner: String?
    var isEmployed: Bool
}

var people = [
    Person(name: "James", age: 45, gender: "Male", partner: "Emily", isEmployed: true),
    Person(name: "Elizabeth", age: 45, gender: "Other", isEmployed: false)
]

let encoder = JSONEncoder()
let peopleJSONData = try! encoder.encode(people)
//print(String(data: peopleJSONData, encoding: .utf8)!)
/*:
 ### More Complex Example
 */
struct Family: Codable {
    enum Gender: String, Codable {
        case Male, Female, Other
    }
    struct Person: Codable{
        var name: String
        var age: Int
        var gender: Gender
        var partner: String?
        var isEmployed: Bool
        
    }
    var familyName: String
    var members: [Person]
    
}

let myFamily = Family(familyName: "Smith",
                      members: [
                        Family.Person(name: "James", age: 45, gender: .Male, partner: "Emily", isEmployed: true),
                        Family.Person(name: "Elizabeth", age: 45, gender: .Other, isEmployed: false)
])

let encoder2 = JSONEncoder()
let myFamilyJSONData = try! encoder2.encode(myFamily)
//print(String(data: myFamilyJSONData, encoding: .utf8)!)
/*:
 ### Encoding Dates
 */

struct Event: Codable {
    var name: String
    var date: Date
    var website: URL
}
let myEvents = [
    Event(name: "Vancouver Envent", date: Date(), website: URL(string: "https://www.vancouverconventioncentre.com")!),
    Event(name: "Los Angelas", date: Date() + 30, website: URL(string: "https://www.staplescenter.com")!)
]

let encoder3 = JSONEncoder()
encoder3.dateEncodingStrategy = .millisecondsSince1970
let myEventsJSONData = try! encoder3.encode(myEvents)
//print(String(data: myEventsJSONData, encoding: .utf8)!)
/*:
 ### Encoding with CodingKeys
 */
class User: Codable, ObservableObject {
    enum CodingKeys: String, CodingKey {
        case name, age_in_years
    }
    @Published var name = "Aidan Lynch"
    var age = 27
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int.self, forKey: .age_in_years)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age_in_years)
    }
}

let Terry = User(name: "Terry Fox", age: 25)
let encoder4 = JSONEncoder()
let TerryJSONData = try! encoder4.encode(Terry)
print(String(data: TerryJSONData, encoding: .utf8)!)
/*:

 [< Previous](@previous)           [Home](Introduction)
 */
