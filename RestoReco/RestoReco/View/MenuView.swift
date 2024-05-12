import SwiftUI

struct MenuView: View {
    @EnvironmentObject var restoViewModel: RestoViewModel
    @State private var searchText = ""
    @State private var sortOptions: [String] = [] // Array to store selected sorting
    
    var filteredRestaurants: [RestaurantModel] {
        
        var filtered = restoViewModel.restaurants
                
        // Filter restaurants based on search text
        if !searchText.isEmpty {
            filtered = filtered.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        
        // Sort restaurants based on selected options
        if sortOptions.isEmpty {
            return filtered
        } else {
            var sortedRestaurants = filtered
            if sortOptions.contains("Rating") {
                sortedRestaurants.sort(by: { $0.rating > $1.rating })
            }
            if sortOptions.contains("Price") {
                sortedRestaurants.sort(by: { ($0.price ?? "") > ($1.price ?? "") })
            }
            if sortOptions.contains("Review") {
                sortedRestaurants.sort(by: { $0.reviewCount > $1.reviewCount })
            }
            return sortedRestaurants
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
                HStack(spacing: 0) {
                    Button(action: {
                        searchText = ""
                    }) {
                        Text("All")
                    }
                    .buttonStyle(CustomButtonStyle())
                    
                    Button(action: {
                        toggleSortOption("Rating")
                    }) {
                        Text(sortButtonText(for: "Rating"))
                    }
                    .buttonStyle(CustomButtonStyle())
                    
                    Button(action: {
                        toggleSortOption("Price")
                    }) {
                        Text(sortButtonText(for: "Price"))
                    }
                    .buttonStyle(CustomButtonStyle())
                    
                    Button(action: {
                        toggleSortOption("Review")
                    }) {
                        Text(sortButtonText(for: "Review"))
                    }
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
                        .padding(.vertical, 8)
                        .padding(.trailing)
                        .background(Color(.systemBackground))
                        .cornerRadius(8)
                        .shadow(radius: 4)
                }
                .listStyle(PlainListStyle())
                
            }
        }
    }
    
    private func toggleSortOption(_ option: String) {
        if let index = sortOptions.firstIndex(of: option) {
            sortOptions.remove(at: index)
        } else {
            sortOptions.append(option)
        }
    }
    
    // Function to generate button text based on sort option
    private func sortButtonText(for option: String) -> String {
        let isSelected = sortOptions.contains(option)
        return "\(option)\(isSelected ? "↑" : "")"
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
