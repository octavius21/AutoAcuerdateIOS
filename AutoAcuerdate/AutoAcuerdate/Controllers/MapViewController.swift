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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//import UIKit
//
//
//class MapViewController: UIViewController, MKMapViewDelegate {
//    var colores = [UIColor.blue, UIColor.green, UIColor.yellow, UIColor.orange,   UIColor.red]
//    var ruta = 0
//    var elMapa:MKMapView!
//    var estadioAzul = CLLocationCoordinate2D(latitude: 19.3834381, longitude: -99.1804635)
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        elMapa = MKMapView()
//        elMapa.frame = self.view.bounds
//        elMapa.delegate = self
//        self.view.addSubview(elMapa)
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        let ad = UIApplication.shared.delegate as! AppDelegate
//        if let centro = ad.elCentro {
//            elMapa.setRegion(MKCoordinateRegion(center:centro, latitudinalMeters:500, longitudinalMeters:500), animated: true)
//            let elPin = MKPointAnnotation()
//            elPin.coordinate = centro
//            elPin.title = "Usted está aqui"
//            elMapa.addAnnotation(elPin)
//            destino()
//        }
//        else {
//            elMapa.setRegion(MKCoordinateRegion(center:CLLocationCoordinate2D(latitude: 19.433926, longitude: -99.142832), latitudinalMeters:500, longitudinalMeters:500), animated: true)
//            NotificationCenter.default.addObserver(self, selector:#selector(ubicacionActualizada(_ :)), name:NSNotification.Name("ubicacion_actualizada"), object: nil)
//        }
//    }
//
//    func mostrarRuta() {
//        /*let linea = MKPolyline(coordinates:[elMapa.centerCoordinate, estadioAzul], count: 2)
//        elMapa.addOverlay(linea)*/
//        let indicaciones = MKDirections.Request()
//        indicaciones.source = MKMapItem(placemark: MKPlacemark(coordinate:elMapa.centerCoordinate))
//        indicaciones.destination = MKMapItem(placemark: MKPlacemark(coordinate:estadioAzul))
//        indicaciones.transportType = .any
//        indicaciones.requestsAlternateRoutes = true
//        let rutas = MKDirections(request: indicaciones)
//        rutas.calculate { response, error in
//            if error != nil {
//                print ("NO se obtuvieron rutas \(String(describing:error))")
//            }
//            else {
//                // El arreglo trae todas las rutas que se obtuvieron
//                guard let lasRutas = response?.routes else { return }
//                /* si queremos dibujar solo una...
//                guard let laRuta = lasRutas.first else { return }*/
//                lasRutas.forEach { laRuta in
//                    self.elMapa.addOverlay(laRuta.polyline)
//                    self.elMapa.setVisibleMapRect(laRuta.polyline.boundingMapRect, animated:false)
//                    self.ruta += 1
//                }
//            }
//        }
//    }
//    
//    func destino () {
//        let elPin = MKPointAnnotation()
//        elPin.coordinate = estadioAzul
//        elPin.title = "META"
//        elMapa.addAnnotation(elPin)
//        mostrarRuta()
//    }
//    
//    @objc func ubicacionActualizada (_ notificacion:Notification) {
//        if let userInfo = notificacion.userInfo {
//            let latitud = userInfo["lat"] as? Double ?? 0
//            let longitud = userInfo["lon"] as? Double ?? 0
//            let nuevaCoordenada = CLLocationCoordinate2D(latitude:latitud, longitude:longitud)
//            elMapa.setRegion(MKCoordinateRegion(center:nuevaCoordenada, latitudinalMeters:500, longitudinalMeters:500), animated: true)
//            let elPin = MKPointAnnotation()
//            elPin.coordinate = nuevaCoordenada
//            elPin.title = "Usted está aqui"
//            elMapa.addAnnotation(elPin)
//            destino()
//        }
//    }
//    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        // se implementa para cambiar la "anotación" o sea la imagen que se muestra
//        let anotacion =  MKMarkerAnnotationView(annotation:annotation, reuseIdentifier:"reuseIdentifier")
//        if annotation.title == "META" {
//            anotacion.glyphImage = UIImage(systemName: "figure.soccer")
//            anotacion.markerTintColor = .blue
//        }
//        else {
//            anotacion.glyphImage = UIImage(systemName: "person.circle")
//        }
//        return anotacion
//    }
//    
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        // se tiene que implementar para poder mostrar lineas y poligonos
//        var lineaParaDibujar = MKPolylineRenderer()
//        if let linea = overlay as? MKPolyline {
//            lineaParaDibujar = MKPolylineRenderer(polyline: linea)
//            lineaParaDibujar.strokeColor = colores[ruta]
//            lineaParaDibujar.lineWidth = 2.0
//        }
//        return lineaParaDibujar
//    }
//}
//
