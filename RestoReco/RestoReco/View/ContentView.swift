import SwiftUI

struct ContentView: View {
    @EnvironmentObject var restoViewModel: RestoViewModel
    
    var body: some View {
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
                VStack(alignment: .leading, spacing: 8) {
                    Text(restaurant.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Text("Rating: \(restaurant.rating)")
                        .foregroundColor(.gray)
                    Text("Reviews: \(restaurant.reviewCount)")
                        .foregroundColor(.gray)
                    Text("Price: \(restaurant.price ?? "N/A")")
                        .foregroundColor(.gray)
                    
                    AsyncImage(url: URL(string: restaurant.imageUrl ?? "")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
                }
                .padding(.vertical, 8)
            }
            .listStyle(PlainListStyle())
            .padding(.horizontal)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(RestoViewModel())
    }
}
