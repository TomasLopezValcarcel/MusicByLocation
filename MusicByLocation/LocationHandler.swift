//
//  LocationHandler.swift
//  MusicByLocation
//
//  Created by Tomas Lopez-Valcarcel on 06/03/2024.
//

import Foundation
import CoreLocation

class LocationHandler: NSObject, CLLocationManagerDelegate, ObservableObject{
    let manager = CLLocationManager()
    let geocoder = CLGeocoder()
    @Published var lastKnownLocation: String = ""
    @Published var lastKnownPostCode: String = ""
    @Published var lastKnownCountry: String = ""
    @Published var lastKnownCountryCode: String = ""

    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestAuthorisation() {
        manager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let firstLocation = locations.first {
            geocoder.reverseGeocodeLocation(firstLocation, completionHandler: { (placemarks, error) in
                if error != nil {
                    self.lastKnownLocation = "Could not look up location from coordinates"
                } else {
                    if let firstPlacemark = placemarks?[0] {
                        self.lastKnownLocation = firstPlacemark.locality ?? "Couldn't find locality"
                        self.lastKnownPostCode = firstPlacemark.postalCode ?? "Couldn't find post code"
                        self.lastKnownCountry = firstPlacemark.country ?? "Couldn't find country"
                        self.lastKnownCountryCode = firstPlacemark.isoCountryCode ?? "Couldn't find country code"


                    }
                }
            })
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        lastKnownLocation = "Error finding location"
    }
}
