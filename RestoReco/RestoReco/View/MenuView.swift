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
                    Button("All", action: {})
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                    
                    Button("List1", action: {})
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                    
                    Button("List2", action: {})
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                    
                    Button("List3", action: {})
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView().environmentObject(RestoViewModel())
    }
}
