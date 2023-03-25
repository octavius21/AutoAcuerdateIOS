//
//  MapViewController.swift
//  AutoAcuerdate
//
//  Created by DISMOV on 22/03/23.
//

import UIKit
import MapKit
class MapViewController: UIViewController, MKMapViewDelegate  {
    var elMapa:MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        elMapa = MKMapView()
        elMapa.frame = self.view.bounds
        elMapa.delegate = self
        self.view.addSubview(elMapa)
        // Do any additional setup after loading the view.
    }
    
    @objc func ubicacionActualizada (_ notificacion:Notification) {
        if let userInfo = notificacion.userInfo {
            let latitud = userInfo["lat"] as? Double ?? 0
            let longitud = userInfo["lon"] as? Double ?? 0
            let nuevaCoordenada = CLLocationCoordinate2D(latitude:latitud, longitude:longitud)
            elMapa.setRegion(MKCoordinateRegion(center:nuevaCoordenada, latitudinalMeters:500, longitudinalMeters:500), animated: true)
            let elPin = MKPointAnnotation()
            elPin.coordinate = nuevaCoordenada
            elPin.title = "Usted está aqui"
            elMapa.addAnnotation(elPin)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                let ad = UIApplication.shared.delegate as! AppDelegate
        elMapa.setRegion(MKCoordinateRegion(center:CLLocationCoordinate2D(latitude: 19.433926, longitude: -99.142832), latitudinalMeters:500, longitudinalMeters:500), animated: true)
                    NotificationCenter.default.addObserver(self, selector:#selector(ubicacionActualizada(_ :)), name:NSNotification.Name("ubicacion_actualizada"), object: nil)
                
    }
}



