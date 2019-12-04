import Foundation

public struct Advert: Codable {
    
    var id: String = ""
    var title: String = ""
    var image: String = ""
    var gallery: [String] = []
    var params: [[String:String]]
    var category: [String:String]
    var description: String = ""
    var color: String = ""
    var user: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case image
        case gallery
        case params
        case category
        case description
        case color
        case user
    }
}

public struct AdvertResponse: Codable {
    
    let status: String?
    let data: Advert
    
    private enum CodingKeys: String, CodingKey {
        case status
        case data
    }
}
