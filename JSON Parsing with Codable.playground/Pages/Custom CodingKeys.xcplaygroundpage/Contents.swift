/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)

 ## Custom CodingKeys

Some JSON does not immediately conform to the Decodable protocol so you may have to do some extra work with CodingKeys to may the JSON comply.

*/
import UIKit
let booksJSON = """
[
  {
    "feed": {
      "publisher": "Penguin",
      "country": "ca"
    },
    "entry": [
      {
        "author": "Margaret Atwood",
        "nationality": "Canadian"
      },
      {
        "author": "Dan Brown",
        "nationality": "American"
      }
    ]
  },
  {
    "feed": {
      "publisher": "Penguin",
      "country": "ca"
    },
    "entry": {
      "author": "Pierre Burton",
      "nationality": "Canadian"
    }
  }
]
"""
struct Book: Decodable {
    enum CodingKeys: String, CodingKey {
        case feed, entry
    }
    struct Feed: Decodable {
        let publisher: String
        let country: String
    }
    struct Entry: Decodable {
        let author: String
        let nationality: String
    }
    let feed: Feed
    let entry: [Entry]
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        feed = try container.decode(Feed.self, forKey: .feed)
        do {
            entry = try container.decode([Entry].self, forKey: .entry)
        } catch {
            let newValue = try container.decode(Entry.self, forKey: .entry)
            entry = [newValue]
        }
    }
}

let decoder = JSONDecoder()
let bookJSONData = booksJSON.data(using: .utf8)!
let books = try! decoder.decode([Book].self, from: bookJSONData)

//for book in books {
//    print(book.feed.publisher)
//    for entry in book.entry {
//        print(entry.author)
//    }
//}
/*:
 ### Adding Decodable conformance for Property Wrappers
Property wrappers such as @Published, do not conform to codable
 */
class User: ObservableObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case name, age
    }
    @Published var name = "Aidan Lynch"
    var age = 27
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int.self, forKey: .age)
    }
}

/*:

 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */
