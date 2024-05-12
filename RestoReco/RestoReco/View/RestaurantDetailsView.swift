//
//  RestaurantDetailsView.swift
//  RestoReco
//
//  Created by Aljonn Santos on 6/5/2024.
//

import SwiftUI
import MapKit

struct RestaurantDetailsView: View {
    let restaurant: RestaurantModel // Restaurant information passed from MenuView
    @State private var region = MKCoordinateRegion()
    @State private var showDetails = true // Flag to control the display of restaurant details
    @State private var showAddPlanner = false

    var body: some View {
        ZStack {
            // Apple Map as background
            Map(coordinateRegion: $region, showsUserLocation: false, annotationItems: [restaurant]) { restaurant in
                MapPin(coordinate: CLLocationCoordinate2D(latitude: restaurant.coordinates.latitude, longitude: restaurant.coordinates.longitude), tint: .red)
            }
            .onAppear {
                // Set region to display the restaurant's location on the map
                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: restaurant.coordinates.latitude, longitude: restaurant.coordinates.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            }
            .edgesIgnoringSafeArea(.all)

            // Details overlay
            VStack(alignment: .leading, spacing: 8) {

                if showDetails { // Show restaurant details if flag is true
                    HStack{
                        Spacer()
                        Text("Restaurant Details")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.vertical, 5)
                            .padding(.horizontal,15)
                            .background(Color.red.opacity(1))
                            .clipShape(Capsule())
                        Spacer()
                    }
                    
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(Color(UIColor.systemBackground)) // Set background color
                        .padding(.horizontal, -20)
                        .padding(.top) // Adjust top padding to overlap slightly with map
                        .padding()
                        .shadow(radius: 10)
                        .overlay(
                            VStack(alignment: .leading, spacing: 8) {
                                Text(restaurant.name)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 8) // Add padding to the title
                                    .foregroundColor(.black)
                                
                                
                                Text("\(String(format: "%.1f", restaurant.rating)) \(Image(systemName: "star.fill")) ")
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.leading)
                                
                                Text("Reviews: \(restaurant.reviewCount)")
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                                if let price = restaurant.price{
                                    Text("Price: \(price)")
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.leading)
                                }
                                Text("\(Image(systemName: "location.fill")) \(restaurant.location.displayAddress.joined(separator: ", "))")
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(2)
                                Text("\(Image(systemName: "phone.fill")) \(restaurant.phone)")
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.leading)
                                HStack {
                                    Spacer()
                                    AsyncImage(url: URL(string: restaurant.imageUrl ?? "")) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .cornerRadius(10)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 200, height: 200)
                                    .cornerRadius(8)
                                    Spacer()
                                }
                                
                                HStack {
                                    Spacer()
                                    // add to planner button
                                    Button(action: {
                                        // implement add to planner
                                        showAddPlanner.toggle()
                                    }) {
                                        Text("Add to Planner")
                                    }
                                    .buttonStyle(CustomButtonStyle())
                                    .padding(.top)
                                    Spacer()
                                }
                            }
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                        )
                } else {
                    // Show a blank space if details are hidden
                    Spacer()
                }
            }
            .padding()

            // Toggle button to show/hide restaurant details
            VStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        showDetails.toggle() // Toggle the flag to show/hide restaurant details
                    }
                }) {
                    Image(systemName: showDetails ? "chevron.up.circle.fill" : "chevron.down.circle.fill")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .padding(5)
                        .background(Color.red.opacity(0.8))
                        .clipShape(Circle())
                }
            }
        }
        .sheet(isPresented: $showAddPlanner) {
            AddPlannerView(restaurant: restaurant, show: $showAddPlanner)
                .presentationDetents([.medium,.large])
        }
    }
}

struct RestaurantDetailsView_Preview: PreviewProvider {
    static var previews: some View {
        let sampleRestaurant = RestaurantModel(id: "1", alias: "sample-restaurant", name: "Sample Restaurant", imageUrl: nil, isClosed: false, url: "https://example.com", reviewCount: 100, categories: [], rating: 4.5, coordinates: RestaurantModel.Coordinates(latitude: 37.7749, longitude: -122.4194), transactions: [], price: "$$", location: RestaurantModel.Location(address1: "123 Sample St", address2: nil, address3: nil, city: "Sample City", zipCode: "12345", country: "USA", state: "CA", displayAddress: ["123 Sample St", "Sample City, CA 12345"]), phone: "123-456-7890", displayPhone: "123-456-7890", distance: 1.0, attributes: RestaurantModel.Attributes(businessTempClosed: nil, menuUrl: nil, open24Hours: nil, waitlistReservation: nil))
        
        let restoViewModel = RestoViewModel()
            RestaurantDetailsView(restaurant: sampleRestaurant)
                .environmentObject(restoViewModel)

        NavigationView {
            RestaurantDetailsView(restaurant: sampleRestaurant)
        }
    }
}


