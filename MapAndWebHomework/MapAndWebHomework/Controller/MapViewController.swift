//
//  MapViewController.swift
//  MapAndWebHomework
//
//  Created by ozgun on 11.01.2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLocationPermission()
    }
    
    func checkLocationPermission() {
        switch self.locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            locationManager.requestLocation()
        case .denied, .restricted:
            //popup gosterecegiz. go to settings butonuna basildiginda
            //kullaniciyi uygulamamizin settings sayfasina gonder
            settingsAlert()
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            fatalError()
        }
    }
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()
    
    @IBAction func button(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    //MARK: - Homework Redirecting to settings with alert

    func settingsAlert() {
        // Create alert message
        let alertController = UIAlertController(title: "Homework 4", message: "Please go to settings to turn on the permissons", preferredStyle: .alert)
        // Create go to settings response and make it direct to settings
        let settingsAction = UIAlertAction(title: "Go to Settings", style: .default) { _ in
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsURL){
                UIApplication.shared.open(settingsURL) { success in }
            }
        }
        // Create cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        // Add actions to alert
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        // Present the alert to screen
        self.present(alertController, animated: true, completion: nil)
    }
}



extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.first?.coordinate else { return }
        print("latitude: \(coordinate.latitude)")
        print("longitude: \(coordinate.longitude)")
        
        mapView.setCenter(coordinate, animated: true)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationPermission()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}

extension MapViewController: MKMapViewDelegate {
    
}




