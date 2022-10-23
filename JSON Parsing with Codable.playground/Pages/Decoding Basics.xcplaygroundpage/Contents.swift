 import UIKit
/*:
 ### Simple Objects
 */
let person1JSON = """
{
    "name": "James",
    "age": 45,
    "gender": "Male",
    "sign": "Sagitarius",
    "partner": "Emily",
    "isEmployed": true
}
"""

let person2JSON = """
{
    "name": "Mary",
    "age": 45,
    "gender": "Female",
    "sign": "Taurus",
    "isEmployed": false
}
"""
struct Person: Decodable {
    let name: String
    let age: Int
    let gender: String
    let sign: String
    let partner: String?
    let isEmployed: Bool
}

let decoder = JSONDecoder()
let person1JSONData = person1JSON.data(using: .utf8)!
let person1 = try! decoder.decode(Person.self, from: person1JSONData)
//print(person1.name)
//print(person1.partner)
let person2JSONData = person2JSON.data(using: .utf8)!
let person2 = try! decoder.decode(Person.self, from: person2JSONData)
//print(person2.name)
//print(person2.partner)
/*:
 ### Arrays
*/
let personsJSON = """
[
    {
        "name": "James",
        "age": 45,
        "gender": "Male",
        "sign": "Sagitarius",
        "partner": "Emily",
        "isEmployed": true
    },
    {
        "name": "Mary",
        "age": 45,
        "gender": "Female",
        "sign": "Taurus",
        "isEmployed": false
    }
]
"""
let personsJSONData = personsJSON.data(using: .utf8)!
let personsArray = try! decoder.decode([Person].self, from: personsJSONData)
for person in personsArray {
//    print("\(person.name)'s partner is \(person.partner ?? "none")")
}
/*:
 #### More Complex Objects
 */
let familyJSON = """
{
    "familyName": "Smith",
    "members": [
        {
            "name": "James",
            "age": 45,
            "gender": "Male",
            "sign": "Sagitarius",
            "partner": "Emily",
            "isEmployed": true
        },
        {
            "name": "Mary",
            "age": 45,
            "gender": "Female",
            "sign": "Taurus",
            "isEmployed": false
        }
    ]
}
"""
struct Family: Decodable {
    let familyName: String
    let members: [Person]
}

let familyJSONData = familyJSON.data(using: .utf8)!
let myFamily = try! decoder.decode(Family.self, from: familyJSONData)
//print(myFamily.familyName)
for member in myFamily.members {
//    print(member.name)
}
/*:
 ## A Better model
 */
struct Family2: Decodable {
    enum Gender: String, Decodable {
        case Male, Female, Other
    }
    struct Person: Decodable {
        let name: String
        let age: Int
        let gender: Gender
        let partner: String?
        let isEmployed: Bool
    }
    let familyName: String
    let members: [Person]
}

let myFamily2 = try! decoder.decode(Family2.self, from: familyJSONData)
print(myFamily2.familyName)
for member in myFamily2.members {
    print(member.name)
}
/*:

 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */
