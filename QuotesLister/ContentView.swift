import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab){
            MainView().environmentObject(ViewModel())
                .tabItem{
                    Image(systemName: "list.clipboard")
                        .padding()
                }
                .tag(0)
            LikesView()
                .tabItem{
                    Image(systemName: "heart.circle")
                }
                .tag(1)
        }
    }
}

#Preview {
    ContentView().modelContainer(for: Quote.self)
}
