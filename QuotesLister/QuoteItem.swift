import Foundation
import SwiftUI
import SwiftData

struct QuoteItem: View{
    @Environment(\.modelContext) var modelContext
    
    var curQuote: Quote
    var body: some View{
        HStack{
            VStack(alignment: .leading){
                Text("\"" + curQuote.content + "\"")
                    .italic()
                Text("    - " + curQuote.author)
                    .padding(.top, 2)
            }
            .padding()
            Spacer()
            Button( action: {
                curQuote.isLiked.toggle()
                try! modelContext.save()
            },
                label: {
                Image(systemName: curQuote.isLiked ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 40, height: 35)
                    .foregroundStyle(.red)
            }
            )
        }
    }
}

#Preview {
    QuoteItem(curQuote: (Quote(id: 1, author: "Andrew", content: "Chem dalshe v les tem bolshe skibidi dop dop yes yes.", isLiked: false)))
}
