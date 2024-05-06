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
                
                // buttons
                HStack(spacing: 20) {
                    Button(action: {
                        // First button action
                    }) {
                        Image(systemName: "calendar")
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color(red: 1.0, green: 0.341, blue: 0.341))
                            .cornerRadius(15)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                    Button(action: {
                        // Second button action
                    }) {
                        Image(systemName: "shuffle")
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color(red: 1.0, green: 0.341, blue: 0.341))
                            .cornerRadius(15)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                    Button(action: {
                        // Third button action
                    }) {
                        Image(systemName: "arrowshape.left.arrowshape.right.fill")
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color(red: 1.0, green: 0.341, blue: 0.341))
                            .cornerRadius(15)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                }
                .padding(.bottom)

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
