//
//  ContentView.swift
//  MusicByLocation
//
//  Created by Tomas Lopez-Valcarcel on 06/03/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var locationHandler = LocationHandler()
    
    var body: some View {
        Form {
            Section{
                HStack{
                    Text("Locality:")
                        .bold()
                    Text(locationHandler.lastKnownLocation)
                }
                HStack {
                        Text("Post Code:")
                            .bold()
                        Text(locationHandler.lastKnownPostCode)
                    }
                HStack {
                        Text("Country:")
                            .bold()
                        Text(locationHandler.lastKnownCountry)
                    }
                HStack {
                        Text("ISO Country Code:")
                            .bold()
                        Text(locationHandler.lastKnownCountryCode)
                    }

            }
            Section {
                Button("Find Music", action: {
                    locationHandler.requestLocation()
                })
            }
        }.onAppear(perform: {
            locationHandler.requestAuthorisation()
        })
    }
}

#Preview {
    ContentView()
}
