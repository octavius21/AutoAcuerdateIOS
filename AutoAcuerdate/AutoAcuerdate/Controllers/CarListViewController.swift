//
//  CarListViewController.swift
//  AutoAcuerdate
//
//  Created by DISMOV on 22/03/23.
//

import UIKit

class CarListViewController: UITableViewController{

    @IBOutlet var carTableView: UITableView!
    var carNew: CarElement?
    var objectsCars = [CarElement]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //carLisActivityIndicator.startAnimating()
        //carLisActivityIndicator.stopAnimating()
        //carLisActivityIndicator.hidesWhenStopped = true
        // Do any additional setup after loading the view.
        carTableView.register(UINib(nibName: "CarItemTableViewCell", bundle: nil), forCellReuseIdentifier: "carCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Consultar el API y serializar el JSON
        guard let laURL = URL(string: "https://private-f5db4f-luisoctaviogomezdelacruzluocz.apiary-mock.com/cars") else { return }
        
        do {
            let bytes = try Data(contentsOf: laURL)
            let cars = try? JSONDecoder().decode(Car.self, from: bytes)
            objectsCars = cars!.car
            self.tableView.reloadData()
        } catch {
            print("Error al descargar el JSON " + String(describing: error))
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objectsCars.count
    }

    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "carCell", for: indexPath) as? CarItemTableViewCell
        
        carNew = objectsCars[indexPath.row]
      
        if let laURL = URL(string:String(carNew!.image)) {
            let configuration = URLSessionConfiguration.ephemeral
            let session = URLSession(configuration: configuration)
            let elReq = URLRequest (url: laURL)
            let task = session.dataTask(with: elReq) { bytes, response, error in
                // Que queremos que pase al recibir el response:
                if error == nil {
                    guard let data = bytes else { return }
                    DispatchQueue.main.async {
                        cell?.carImageView.image = UIImage(data: data)
                    }
                }
            }
            task.resume()
        }
        cell?.carBrandLabel.text = carNew?.brand ?? "UNKNOWED"
        if (carNew?.model) == nil{
            cell?.carModelLabel.text = ""
        }else{
            cell?.carModelLabel.text = String(carNew!.model)
        }
        switch(carNew?.colorPlate.uppercased()){
        case "AMARILLO":
            cell?.colorPlateImageView.backgroundColor = UIColor.yellow
        case "ROSA":
            cell?.colorPlateImageView.backgroundColor = UIColor.systemPink
        case "AZUL":
            cell?.colorPlateImageView.backgroundColor = UIColor.blue
        case "VERDE":
            cell?.colorPlateImageView.backgroundColor = UIColor.green
        case "ROJO":
            cell?.colorPlateImageView.backgroundColor = UIColor.red
        default:
            cell?.colorPlateImageView.backgroundColor = UIColor.white
        }
        cell?.plateLabel.text = carNew?.licensePlate ?? ""
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        carNew = objectsCars[indexPath.row]
        performSegue(withIdentifier: "showCar", sender: self)
    }
    
    // Prepara el lanzamiento del Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCar"{
            let destination = segue.destination as! CarDetailViewController
            //Enviar el dato
            destination.carSend = carNew
            //carTableView.indexPathForSelectedRow!.row
        }
        
        //destination.recivedPersonaje = carNew
    }
    //Le dice al delegado que una fila esta a punto de ser selccionada
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        carNew = objectsCars[indexPath.row]
        return indexPath
    }
    

  

}
