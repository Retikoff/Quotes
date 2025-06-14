import Foundation
import Alamofire
import Combine

class ApiService{
    static let BASIC_URL = "https://dummyjson.com/quotes/random"
    
    func getQuotes() -> AnyPublisher <Quote, AFError> {
        let publisher = AF.request(ApiService.BASIC_URL, method: .get)
            .publishDecodable(type: Quote.self)
        
        return publisher.value()
    }
}
