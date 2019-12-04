import Foundation

public struct Category: Codable {
    var id: String = ""
    var title: String = ""
    var image: String = ""
}
public struct CategoryListResponse: Codable {
    
    let status: String?
    let data: [Category]
    
    private enum CodingKeys: String, CodingKey {
        case status
        case data
    }
}
