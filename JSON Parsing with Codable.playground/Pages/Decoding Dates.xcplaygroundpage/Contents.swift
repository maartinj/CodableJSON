/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)

 ## Decoding Dates
There are many ways to represent a date on the Internet.  ISO-8601 is the most command and Decodable is able to handle dates that are in that format. but what if you have a date in your JSON file or fee that is a differen format?
*/
import UIKit// Consider this json code snippet
/*:
 ### Example 1
 DateFormatter strategy
 */
let personJson = """
{
  "id" : 7,
  "name" : "Aidan Lynch",
  "birthday" : "27-03-1993",
}
"""
struct Person: Decodable {
    let id: Int
    let name: String
    let birthday: String
}
let formatter = DateFormatter()
formatter.dateFormat = "dd-MM-yyyy"

let personJSONData = personJson.data(using: .utf8)!
let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .formatted(formatter)
let thisPerson = try! decoder.decode(Person.self, from: personJSONData)
print(thisPerson.birthday)
/*:
### Example 2
 Other DateDecodingStrategies
*/
struct Event: Decodable {
    let name: String
    let date: Date
    let website: URL
}

guard let sourceURL = Bundle.main.url(forResource: "Events", withExtension: "json") else {
    fatalError("Could not find Events.json")
}

guard let eventJSONData = try? Data(contentsOf: sourceURL) else {
    fatalError("Could not convert to data")
}

let decoder2 = JSONDecoder()
decoder2.dateDecodingStrategy = .secondsSince1970

guard let events = try? decoder2.decode([Event].self, from: eventJSONData) else {
    fatalError("There must be a problem decoding the data.....")
}

for event in events {
    print(event.name)
    print(event.date)
    print(event.website)
}
