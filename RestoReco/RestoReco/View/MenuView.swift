import SwiftUI

struct MenuView: View {
    @EnvironmentObject var restoViewModel: RestoViewModel
    
    var body: some View {
        NavigationStack{
            VStack {
                Image(systemName: "fork.knife")
                    .foregroundColor(.black)
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                
                Text("RestoReco")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.bottom, 20)
                
                List(restoViewModel.restaurants, id: \.id) { restaurant in
                    NavigationLink(destination: RestaurantDetailsView(/*pass in restaurant*/)){
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                AsyncImage(url: URL(string: restaurant.imageUrl ?? "")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 100, height: 100)
                                .cornerRadius(8)
                                
                                Spacer()
                                
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
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView().environmentObject(RestoViewModel())
    }
}
