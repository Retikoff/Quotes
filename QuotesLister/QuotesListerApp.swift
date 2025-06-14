import SwiftUI

@main
struct QuotesListerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Quote.self)
    }
}
