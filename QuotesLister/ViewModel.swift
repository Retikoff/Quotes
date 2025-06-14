import Foundation
import Alamofire
import Combine
import SwiftUI


class ViewModel: ObservableObject {
    @Published var newQuote: Quote = Quote()
    
    var cancellation: AnyCancellable?
    let service = ApiService()
    
    var idForNew = 10000
    
    public func incrementId(){
        idForNew += 1
    }
    
    init(){
        getQuote()
    }
    
    func getQuote(){
        cancellation = service.getQuotes()
            .mapError({(error) -> Error in
                print("Download error! \(error)")
                return error
            })
            .sink(receiveCompletion: {_ in }, receiveValue: { data in
               
                self.newQuote = data
                
                print("Quote to add: \(self.newQuote.content)")
            })
    }
}
