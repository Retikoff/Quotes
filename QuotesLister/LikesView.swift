import Foundation
import SwiftUI
import SwiftData

struct LikesView: View {
    @Environment(\.modelContext) var modelContext
    @Query(filter: #Predicate<Quote>{quote in
        quote.isLiked == true
    }, sort: \Quote.id, order: SortOrder.forward) var quotes: [Quote]
        
    
    @State var searchText = ""
    
    var body: some View{
        VStack{
            if quotes.isEmpty {
                Text("You haven't liked any quote yet")
                    .font(.system(size: 24))
                    .padding()
                Image(systemName: "heart")
                    .resizable()
                    .frame(width:48, height: 48)
            }
            else{
                Text("You have " + String(quotes.count) + " liked quotes")
                    .font(.system(size: 24))
                    .padding()
                NavigationStack{
                    List{
                        ForEach(searchResults, id:\.id){quote in
                            QuoteItem(curQuote: quote)
                        }
                        .onDelete(perform: deleteQuote)
                    }
                    .listStyle(.plain)
                }
                .searchable(text: $searchText)
            }
        }
    }
    
    func deleteQuote(_ indexSet: IndexSet){
        for index in indexSet {
            let quoteToDelete = quotes[index]
            modelContext.delete(quoteToDelete)
        }
        
        try! modelContext.save()
    }

    var searchResults: [Quote]{
        if searchText.isEmpty {
            return quotes
        }
        else{
            return quotes.filter{$0.author.contains(searchText) || $0.content.contains(searchText)}
        }
    }
}

#Preview{
    LikesView()
}
