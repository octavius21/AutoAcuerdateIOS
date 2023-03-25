//
//  InternetMonitor.swift
//  AutoAcuerdate
//
//  Created by DISMOV on 24/03/23.
//

import Foundation
import Network
// Por si se ncesita que esta clase implemente algun protocolo, es mejor que herede explicitamente de NSObject
class InternetMonitor: NSObject{
    
    var internetStatus = false
    var internetType = ""
    //Implementar Singleton
    //1) debe haber una unica instancia
    static let instance = InternetMonitor()
    //2)Para graantizar que esta clase no se pueda instanciar
    override private init(){
        super.init()
        startDetection()
        
    }
    
    func startDetection(){
        let monitor = NWPathMonitor()
                // ....
                monitor.start(queue:DispatchQueue.global())
                monitor.pathUpdateHandler = { path in
                    if path.status == .satisfied {
                        // ejecutar un Ping para alcanzar el host que nos interesa (TODO: buscar un paquete que haga eso....)
                        self.internetStatus = true
                        if path.usesInterfaceType(.wifi) {
                            self.internetType = "WiFi"
                        }
                        else {
                            self.internetType = "no WiFi"
                        }
                    }
                    else {
                        self.internetStatus = false
                        self.internetType = ""
                    }
                }
    }
    
}
