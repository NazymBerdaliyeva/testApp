import Foundation

public struct Adverts: Codable {
    var id: String = ""
    var title: String = ""
    var image: String = ""
    var category: [String:String]
    var description: String = ""
    var color: String = ""
    var user: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case image
        case category
        case description
        case color
        case user
    }
}
public struct AdvertsListResponse: Codable {
    
    let status: String?
    let data: [Adverts]
    
    private enum CodingKeys: String, CodingKey {
        case status
        case data
    }
}

