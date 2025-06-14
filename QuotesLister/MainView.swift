import Foundation
import SwiftUI
import SwiftData

struct MainView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Quote.id, order: SortOrder.forward) var quotes: [Quote]
    
    @State var showCreateView = false
    @State var searchText = ""
    
    var body: some View{
        VStack{
            HStack{
                Button(action: {
                    viewModel.getQuote()
                    modelContext.insert(viewModel.newQuote)
                    try! modelContext.save()
                } , label: {
                    Image(systemName:"die.face.6")
                        .resizable()
                        .frame(width: 28, height:28)
                    Text("random")
                        .font(.system(size: 22))
                        .frame(width: 120, height: 40)
                        
                })
                .buttonStyle(.borderedProminent)
                Button(action: {
                    showCreateView = true
                }
                       ,label: {
                    Image(systemName:"sparkles")
                        .resizable()
                        .frame(width: 28, height: 28)
                    Text("new")
                        .padding(0)
                        .font(.system(size: 22))
                        .frame(width: 120, height: 40)
                })
                .buttonStyle(.borderedProminent)
                .sheet(isPresented: $showCreateView){
                    CreateView(showCreateView: $showCreateView)
                }
            }
            .padding(.top, 16)
            NavigationStack{
                List{
                    ForEach(searchResults, id: \.self){quote in
                        QuoteItem(curQuote: quote)
                    }
                    .onDelete(perform: deleteQuote)
                }
                .listStyle(.plain)
            }
            .searchable(text: $searchText)
            .padding(.top, 2)
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
        if searchText.isEmpty{
            return quotes
        }
        else{
            return quotes.filter{$0.content.contains(searchText) || $0.author.contains(searchText)}
        }
    }
}

#Preview {
    MainView().environmentObject(ViewModel()).modelContainer(for: Quote.self)
}
