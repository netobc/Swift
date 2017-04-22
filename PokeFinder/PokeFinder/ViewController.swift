//
//  ViewController.swift
//  PokeFinder
//
//  Created by Ernesto De La Trinidad Vidana on 9/10/16.
//  Copyright © 2016 NetoCo. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var mapHasCenterOne = false
    var geofire: GeoFire!
    var geofireRef: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow
        geofireRef = FIRDatabase.database().reference()
        geofire = GeoFire(firebaseRef: geofireRef)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationAuthStatus()
    }
    
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        }
    }
    
    func centerMapOnLoc (location: CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
        mapView.setRegion(coordinateRegion, animated: true)
        
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if let loc = userLocation.location {
            if !mapHasCenterOne {
                centerMapOnLoc(location: loc)
                mapHasCenterOne = true
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var AnnotationView: MKAnnotationView?
        let AnnoIdentifier = "Pokemon"
        if annotation.isKind(of: MKUserLocation.self){
            AnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "User")
            AnnotationView?.image = UIImage(named: "ash")
        } else if let deqAnnotation = mapView.dequeueReusableAnnotationView(withIdentifier: AnnoIdentifier){
            AnnotationView = deqAnnotation
            AnnotationView?.annotation = annotation
        } else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: AnnoIdentifier)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            AnnotationView = av
        }
        if let AnnotationView = AnnotationView, let anno = annotation as? PokeAnnotation {
            AnnotationView.canShowCallout = true
            AnnotationView.image =  UIImage(named: "\(anno.pokemonNumber)")
            let btn = UIButton()
            btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            AnnotationView.rightCalloutAccessoryView = btn
        }
        return AnnotationView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createSighting (forLocation location: CLLocation, withPokemon pokeId: Int){
        geofire.setLocation(location, forKey: "\(pokeId)" )
    }
    
    func showSightsonMap (location: CLLocation){
        let circleQuery = geofire!.query(at: location, withRadius: 2.5) //Kilometers
        _ = circleQuery?.observe(GFEventType.keyEntered, with: {(key, location) in
            if let key = key, let location = location {
                let anno = PokeAnnotation(coordinate: location.coordinate, pokemonNumber: Int(key)!)
                self.mapView.addAnnotation(anno)
            }
        })
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        let loc = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        showSightsonMap(location: loc)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let anno = view.annotation as? PokeAnnotation {
            let place = MKPlacemark(coordinate: anno.coordinate)
            let destination = MKMapItem(placemark: place)
            destination.name = "Pokemon Sightings"
            let regionDistance : CLLocationDistance = 1000
            let regionSpan = MKCoordinateRegionMakeWithDistance(anno.coordinate, regionDistance, regionDistance)
            let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span), MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving] as [String : Any]
            
            MKMapItem.openMaps(with: [destination], launchOptions: options)
        }
    }
    
    @IBAction func SpotRandomPokemon(_ sender: AnyObject) {
        
        let loc = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        let rand = arc4random_uniform(151)+1
        createSighting(forLocation: loc, withPokemon: Int(rand))
    }

}

