import SwiftUI

struct MenuView: View {
    @EnvironmentObject var restoViewModel: RestoViewModel
    @State private var searchText = ""
    @State private var isRatingAscending = false
    @State private var isPriceAscending = false
    @State private var isReviewCountAscending = false
    
    var filteredRestaurants: [RestaurantModel] {
        
        var filtered = restoViewModel.restaurants
        
        // Filter restaurants based on search text
        if !searchText.isEmpty {
            filtered = filtered.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        
        // Sort restaurants based on rating
        if isRatingAscending {
            isPriceAscending = false
            isReviewCountAscending = false
        }
        
        filtered.sort {
            if isRatingAscending {
                return $0.rating > $1.rating
            } else {
                return $0.rating < $1.rating
            }
        }
        
        if isRatingAscending {
            return filtered
        }
        
        // Sort restaurants based on price
        if isPriceAscending {
            isRatingAscending = false
            isReviewCountAscending = false
        }
        
        filtered.sort {
            if isPriceAscending {
                return $0.price ?? "" > $1.price ?? ""
            } else {
                return $0.price ?? "" < $1.price ?? ""
            }
        }
        
        if isPriceAscending {
            return filtered
        }
        
        // Sort restaurants based on review count
        if isReviewCountAscending {
            isRatingAscending = false
            isPriceAscending = false
        }
        
        filtered.sort {
            if isReviewCountAscending {
                return $0.reviewCount > $1.reviewCount
            } else {
                return $0.reviewCount < $1.reviewCount
            }
        }
        
        if isReviewCountAscending {
            return filtered
        }
        
        return filtered
        
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
                HStack(spacing: 5) {
                    Button(action: {
                        searchText = ""
                    }) {
                        Text("All")
                    }
                    .buttonStyle(CustomButtonStyle())
                    
                    
                    Button(action: {
                        isRatingAscending.toggle()
                    }) {
                        Text(isRatingAscending ? "Rate↑" : "Rate")
                    }
                    .buttonStyle(CustomButtonStyle())
                    
                    Button(action: {
                        isPriceAscending.toggle()
                    }) {
                        Text(isPriceAscending ? "Price↑" : "Price")
                    }
                    .buttonStyle(CustomButtonStyle())
                    
                    Button(action: {
                        isReviewCountAscending.toggle()
                    }) {
                        Text(isReviewCountAscending ? "Review↑" : "Review")
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
