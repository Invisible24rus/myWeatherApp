//
//  getCityWeather.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 13.03.2022.
//

import Foundation
import CoreLocation
import MapKit

func getCoordinateFrom(city: String, completion: @escaping (_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
    CLGeocoder().geocodeAddressString(city) { (placemark, error) in
        completion(placemark?.first?.location?.coordinate, error)
    }
}


