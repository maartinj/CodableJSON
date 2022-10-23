/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)

 ## JSON From API
At some point in your career you are going to have to fetch or Get some data from an API.  In this section we will create a generic function that you can reuse to fetch the majority of feeds and decode it.
*/
import UIKit
/*:
 ### Create struct for GitHub Follower
 */
struct GHFollower: Decodable {
    let login: String
    let id: Int
}
/*:
### Create create a function that will retrieve the data
*/
//func getJSON() {
//    guard let url = URL(string: "https://api.github.com/users/twostraws/followers") else {
//        return
//    }
//    let request = URLRequest(url: url)
//    URLSession.shared.dataTask(with: request) { (data, response, error) in
//        if let error = error {
//            print(error.localizedDescription)
//            return
//        }
//        guard let data = data else {
//            return
//        }
//        let decoder = JSONDecoder()
//        guard let decodedData = try? decoder.decode([GHFollower].self, from: data) else {
//            return
//        }
//
//        let followers = decodedData
//        for follower in followers {
//            print(follower.login)
//        }
//    }.resume()
//}
//getJSON()
/*:
### Update the function to use a closure
*/
//func getJSON(urlString: String, completion: @escaping ([GHFollower]?) -> Void) {
//    guard let url = URL(string: urlString) else {
//        return
//    }
//    let request = URLRequest(url: url)
//    URLSession.shared.dataTask(with: request) { (data, response, error) in
//        if let error = error {
//            print(error.localizedDescription)
//            completion(nil)
//            return
//        }
//        guard let data = data else {
//            completion(nil)
//            return
//        }
//        let decoder = JSONDecoder()
//        guard let decodedData = try? decoder.decode([GHFollower].self, from: data) else {
//            completion(nil)
//            return
//        }
//
//        completion(decodedData)
//    }.resume()
//}
//getJSON(urlString: "https://api.github.com/users/twostraws/followers") { (followers) in
//    if let followers = followers {
//        for follower in followers {
//            print(follower.login)
//        }
//    }
//}
/*:
### Change the function to use generics
*/
func getJSON<T: Decodable>(urlString: String, completion: @escaping (T?) -> Void) {
    guard let url = URL(string: urlString) else {
        return
    }
    let request = URLRequest(url: url)
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print(error.localizedDescription)
            completion(nil)
            return
        }
        guard let data = data else {
            completion(nil)
            return
        }
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            completion(nil)
            return
        }
        
        completion(decodedData)
    }.resume()
}
getJSON(urlString: "https://api.github.com/users/twostraws/followers") { (followers: [GHFollower]?) in
    if let followers = followers {
        for follower in followers {
            print(follower.login)
        }
    }
}
/*:
### Use itunes Store API to find 25 Beatles songs
*/
getJSON(urlString: "https://itunes.apple.com/search?term=jack+johnson&limit=25") { (searchResults: ITunesSearch?) in
    if let searchResults = searchResults {
        for result in searchResults.results {
            print(result.trackName ?? "-")
        }
    }
}
/*:

 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */
