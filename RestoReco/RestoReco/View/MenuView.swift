import SwiftUI

struct MenuView: View {
    @EnvironmentObject var restoViewModel: RestoViewModel
    @State private var searchText = ""
    
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
                
//                Text("RestoReco")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .foregroundColor(.red)
//                    .padding(.bottom, 20)
            
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
                
                // text purpose to see searchText value
                Text(searchText)
                
                // categories
                HStack(spacing: 10) {
                    Button(action: {}) {
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
                
                List(restoViewModel.restaurants, id: \.id) { restaurant in
                    NavigationLink(destination: RestaurantDetailsView(/*pass in restaurant*/)){
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 20) {
                                AsyncImage(url: URL(string: restaurant.imageUrl ?? "")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 100, height: 100)
                                .cornerRadius(8)
                                
                                VStack(alignment: .leading){
                                    Text(restaurant.name)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    
                                    Text("Rating: \(restaurant.rating)")
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.leading)
                                    Text("Reviews: \(restaurant.reviewCount)")
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.leading)
                                    Text("Price: \(restaurant.price ?? "N/A")")
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.leading)
                                }
                                Spacer()
                                
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .listStyle(PlainListStyle())
                .padding(.horizontal)
                
            }
//            .padding()
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
