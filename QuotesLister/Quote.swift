import Foundation
import SwiftData

@Model
class Quote: Codable{
    var id: Int
    var author: String
    var content: String
    var isLiked: Bool = false
    
    init(){
        self.id = 0
        self.author = ""
        self.content = ""
    }
    
    init(id: Int, author: String, content: String, isLiked: Bool) {
        self.id = id
        self.author = author
        self.content = content
        self.isLiked = isLiked
    }
    
    public func encode(to encoder: any Encoder) throws{
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(author, forKey: .author)
        try container.encode(content, forKey: .content)
    }
    
    required init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        author = try values.decode(String.self, forKey: .author)
        content = try values.decode(String.self, forKey: .content)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case content = "quote"
        case author = "author"
    }
}
