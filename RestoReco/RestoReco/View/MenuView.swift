import SwiftUI

struct MenuView: View {
    @EnvironmentObject var restoViewModel: RestoViewModel
    @State private var searchText = ""
    
    var filteredRestaurants: [RestaurantModel] {
        if searchText.isEmpty {
            // If searchText is empty, return all restaurants
            return restoViewModel.restaurants
        }
        else {
            // Filter restaurants based on searchText
            return restoViewModel.restaurants.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                Image(systemName: "fork.knife")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 50, maxHeight: 50)
                    .foregroundColor(.red)
                    .foregroundStyle(.tint)
                    .padding(.bottom)
                
                // Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.leading, 1)
                    
                    TextField("Search", text: $searchText)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .foregroundColor(.black)
                }
                .padding(.horizontal)
                Spacer()
                
                // categories
                HStack(spacing: 10) {
                    Button(action: {
                        searchText = ""
                    }) {
                        Text("All")
                    }
                    .buttonStyle(CustomButtonStyle())

                    
                    Button("List1", action: {})
                        .buttonStyle(CustomButtonStyle())
                    
                    Button("List2", action: {})
                        .buttonStyle(CustomButtonStyle())
                    
                    Button("List3", action: {})
                        .buttonStyle(CustomButtonStyle())
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                // List of filtered restaurants
                List(filteredRestaurants, id: \.id) { restaurant in
                    NavigationLink(destination: RestaurantDetailsView(/*pass in restaurant*/
                        restaurant: restaurant)) {
                        VStack(alignment: .leading, spacing: 8) {
                            RestaurantOverview(restaurant: restaurant)
                        }
                        .padding(.vertical, 8)
                    }
                }
                .listStyle(PlainListStyle())
                .padding(.horizontal)
                
            }
        }
    }
}

//reusable style for button
struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(Color.red)
            .cornerRadius(20)
            .shadow(color: .gray, radius: 2, x: 1, y: 2)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // Add a scale effect when pressed
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView().environmentObject(RestoViewModel())
    }
}
