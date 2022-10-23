/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)

 ## CodingKeys
If your classes or structures use differnt property names than what the feed contains, you are going to have to map the keys to the class or struct property names.
*/
import UIKit
struct ColorPalette: Decodable {
    enum CodingKeys: String, CodingKey {
        case name = "palette_name"
        case info  = "palette_info"
        case colors = "palette_colors"
    }
    struct PaletteColor: Decodable {
        enum CodingKeys: String, CodingKey {
            case order = "sort_order"
            case description = "description"
            case red = "red"
            case green = "green"
            case blue = "blue"
            case alpha = "alpha"
        }
        let order: Int
        let description: String
        let red: Int
        let green: Int
        let blue: Int
        let alpha: Double
    }
    let name: String
    let info: String
    let colors: [PaletteColor]
}
guard let sourcesURL = Bundle.main.url(forResource: "FlatColors", withExtension: "json") else {
    fatalError("Could not find FlatColors.json")
}
guard let colorData = try? Data(contentsOf: sourcesURL) else {
    fatalError("Could not conver data")
}

let decoder = JSONDecoder()
guard let flatColors = try? decoder.decode(ColorPalette.self, from: colorData) else {
    fatalError("There was a problem decoding the data....")
}
print(flatColors.name)
for color in flatColors.colors {
    print(color.description)
}
/*:

 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */
