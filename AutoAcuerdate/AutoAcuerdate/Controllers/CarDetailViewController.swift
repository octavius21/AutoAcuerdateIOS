//
//  CarDetailViewController.swift
//  AutoAcuerdate
//
//  Created by DISMOV on 23/03/23.
//

import UIKit

class CarDetailViewController: UIViewController {
    
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var plateLabel: UILabel!
    @IBOutlet weak var colorPlateImageView: UIView!
    @IBOutlet weak var nacionalityLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var leftUpTireLabel: UILabel!
    @IBOutlet weak var rightUpTireLabel: UILabel!
    @IBOutlet weak var rightDownTireLabel: UILabel!
    @IBOutlet weak var leftDownTireLabel: UILabel!
 
    var carSend : CarElement?
    var carView : CarElement?
    override func viewDidLoad() {
        super.viewDidLoad()
        if !InternetMonitor.instance.internetStatus{
            let alert = UIAlertController(title: "Need it Internet Conection", message: "This App need it Internet for used", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (okSelected) -> Void in
                self.dismiss(animated: true)
            }
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
            
            self.dismiss(animated: true)
            let isModal = self.presentingViewController is UINavigationController
            if isModal{
                self.dismiss(animated: true)
            }
            else{
                navigationController?.popViewController(animated: true)
            }
        }else{
            // Consultar el API y serializar el JSON
            guard let laURL = URL(string: "https://private-f5db4f-luisoctaviogomezdelacruzluocz.apiary-mock.com/cars?id_car\(String(carSend!.idCar))") else { return }
            print(laURL)
            
            do {
                let bytes = try Data(contentsOf: laURL)
                let car = try? JSONDecoder().decode(CarElement.self, from: bytes)
                carView = car
            } catch {
                print("Error al descargar el JSON " + String(describing: error))
            }
            brandLabel.text = carView?.brand.uppercased() ?? "UNKNOWED"
            if let laURL = URL(string:String(carView!.image)) {
                let configuration = URLSessionConfiguration.ephemeral
                let session = URLSession(configuration: configuration)
                let elReq = URLRequest (url: laURL)
                let task = session.dataTask(with: elReq) { bytes, response, error in
                    // Que queremos que pase al recibir el response:
                    if error == nil {
                        guard let data = bytes else { return }
                        DispatchQueue.main.async {
                            self.carImageView.image = UIImage(data: data)
                        }
                    }
                }
                task.resume()
            }
            switch(carView?.colorPlate.uppercased()){
            case "AMARILLO":
                colorPlateImageView.backgroundColor = UIColor.yellow
            case "ROSA":
                colorPlateImageView.backgroundColor = UIColor.systemPink
            case "AZUL":
                colorPlateImageView.backgroundColor = UIColor.blue
            case "VERDE":
                colorPlateImageView.backgroundColor = UIColor.green
            case "ROJO":
                colorPlateImageView.backgroundColor = UIColor.red
            default:
                colorPlateImageView.backgroundColor = UIColor.white
            }
            plateLabel.text = "\(carView?.licensePlate ?? "AAA-123")"
            nacionalityLabel.text = "International: \(carView?.origin ?? "International")"
            if (carView?.model) == nil{
                modelLabel.text = "Model: "
            }else{
                modelLabel.text = "Model: \(String(carView!.model))"
            }
            leftUpTireLabel.text = "Tire pressure: \(carView?.leftPressureTireFront ?? "0")"
            rightUpTireLabel.text = "Tire pressure: \(carView?.rightPressureTireFront ?? "0")"
            leftDownTireLabel.text = "Tire pressure: \(carView?.leftPressureTireBehavior ?? "0")"
            rightDownTireLabel.text = "Tire pressure: \(carView?.rightPressureTireBehavior ?? "0")"
        }
    }

}
