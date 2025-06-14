import Foundation
import SwiftUI
import SwiftData

struct CreateView: View{
    @EnvironmentObject var viewModel: ViewModel
    
    @Binding var showCreateView:Bool
    
    @Environment(\.modelContext) var modelContext
    
    @State var curContent: String = ""
    @State var curAuthor: String = ""
    var body: some View{
        VStack{
            Text("New Quote")
                .font(.system(size: 38))
                .bold()
                .padding()
            Spacer()
            
            Text("Author:")
                .font(.system(size: 24))
            TextField("Author:", text: $curAuthor)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(Color(UIColor.systemGray4), lineWidth: 2)}
                .frame(width: 280)
                .autocorrectionDisabled(true)
            
            Text("Quote:")
                .font(.system(size: 24))
            
            TextField("Quote:", text: $curContent)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(Color(UIColor.systemGray4), lineWidth: 2)}
                .frame(width: 280)
                .autocorrectionDisabled(true)
            
            Spacer()
            
            Button(action: {
                let newId = viewModel.idForNew
                modelContext.insert(Quote(id: newId, author: curAuthor, content: curContent, isLiked: false))
                
                viewModel.incrementId()
                try! modelContext.save()
                
                showCreateView = false
            }
            , label: {
              Text("Add quote")
                    .bold()
                    .font(.system(size: 24))
                    .frame(width: 280)
            })
            .buttonStyle(.borderedProminent)
            
        }
    }
}

#Preview{
    CreateView(showCreateView: .constant(true)).environmentObject(ViewModel())
}
