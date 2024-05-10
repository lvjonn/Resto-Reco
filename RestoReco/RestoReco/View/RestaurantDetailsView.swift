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
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(Color(UIColor.systemBackground)) // Set background color
                        .padding(.top, 50) // Adjust top padding to overlap slightly with map
                        .padding()
                        .overlay(
                            VStack(alignment: .leading, spacing: 8) {
                                Text(restaurant.name)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 8) // Add padding to the title
                                Text("Rating: \(String(format: "%.1f", restaurant.rating))")
                                Text("Reviews: \(restaurant.reviewCount)")
                                Text("Price: \(restaurant.price ?? "N/A")")
                                Text("Location: \(restaurant.location.address1)")
                                Text("Phone: \(restaurant.phone)")
                                
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
                            }
                            .foregroundColor(.black)
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
                        .padding()
                        .background(Color.black.opacity(0.6))
                        .clipShape(Circle())
                }
                .padding(.bottom, 20)
                .padding(.trailing, 20)
            }
        }
        .navigationTitle("Restaurant Details")
    }
}

struct RestaurantDetailsView_Preview: PreviewProvider {
    static var previews: some View {
        let sampleRestaurant = RestaurantModel(id: "1", alias: "sample-restaurant", name: "Sample Restaurant", imageUrl: nil, isClosed: false, url: "https://example.com", reviewCount: 100, categories: [], rating: 4.5, coordinates: RestaurantModel.Coordinates(latitude: 37.7749, longitude: -122.4194), transactions: [], price: "$$", location: RestaurantModel.Location(address1: "123 Sample St", address2: nil, address3: nil, city: "Sample City", zipCode: "12345", country: "USA", state: "CA", displayAddress: ["123 Sample St", "Sample City, CA 12345"]), phone: "123-456-7890", displayPhone: "123-456-7890", distance: 1.0, attributes: RestaurantModel.Attributes(businessTempClosed: nil, menuUrl: nil, open24Hours: nil, waitlistReservation: nil))

        NavigationView {
            RestaurantDetailsView(restaurant: sampleRestaurant)
        }
    }
}


