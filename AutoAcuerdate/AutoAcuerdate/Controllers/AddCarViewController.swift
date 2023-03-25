//
//  AddCarViewController.swift
//  AutoAcuerdate
//
//  Created by DISMOV on 21/03/23.
//

import UIKit

class AddCarViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    //Pickers
    @IBOutlet weak var brandPickerView: UIPickerView!
    @IBOutlet weak var nationalityPickerView: UIPickerView!
    @IBOutlet weak var colorPickerView: UIPickerView!
    @IBOutlet weak var tireUpRightPickerView: UIPickerView!
    @IBOutlet weak var tireUpLeftPickerView: UIPickerView!
    @IBOutlet weak var tireDownRightPicker: UIPickerView!
    @IBOutlet weak var tireDownLeftPicker: UIPickerView!
    //Image
    @IBOutlet weak var imageCarImageView: UIImageView!
    //Buttons
    @IBOutlet weak var addImageButton: UIButton!
    //TextField
    @IBOutlet weak var plateTextField: UITextField!
    //Variables
    @IBOutlet weak var cancelCarButton: UIButton!
    
    @IBOutlet weak var saveEditCarButton: UIButton!
    private var brandPickerViewValues = ["Volskwagen","Toyota", "Seat", "Jeep", "Tesla"]
    private let nationalityPickerViewValues = ["EUA", "Mexico", "Aleman", "Italiano"]
    private let colorPickerViewValues = ["AMARILLO", "ROSA", "ROJO", "AZUL", "VERDE", "NONE"]
    private let tirePressureValues = 29...41
    var carSend : CarElement?
    var carRowSend : Int?
    var carGet: CarElement?
    
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
           
            brandPickerView?.dataSource = self
            brandPickerView?.delegate = self
            nationalityPickerView?.dataSource = self
            nationalityPickerView?.delegate = self
            colorPickerView?.dataSource = self
            colorPickerView?.delegate = self
            tireUpRightPickerView?.dataSource = self
            tireUpRightPickerView?.delegate = self
            tireUpLeftPickerView?.dataSource = self
            tireUpLeftPickerView?.delegate = self
            tireDownRightPicker?.dataSource = self
            tireDownRightPicker?.delegate = self
            tireDownLeftPicker?.dataSource = self
            tireDownLeftPicker?.delegate = self
            plateTextField?.delegate = self
            if(carGet == nil){
                cancelCarButton.isHidden = true
                saveEditCarButton.isHidden = true
            }
        }
       
    }
    override func viewWillAppear(_ animated: Bool) {
        searchValues()
    }
    func searchValues(){
        if(carGet != nil){
            if let laURL = URL(string:String(carGet!.image)) {
                let configuration = URLSessionConfiguration.ephemeral
                let session = URLSession(configuration: configuration)
                let elReq = URLRequest (url: laURL)
                let task = session.dataTask(with: elReq) { bytes, response, error in
                    // Que queremos que pase al recibir el response:
                    if error == nil {
                        guard let data = bytes else { return }
                        DispatchQueue.main.async {
                            self.imageCarImageView.image = UIImage(data: data)
                        }
                    }
                }
                task.resume()
            }
            plateTextField.text = carGet!.licensePlate ?? ""
            var posicion = 0
            if carGet!.brand != ""{
                for (index, dato) in brandPickerViewValues.enumerated(){
                    if carGet!.brand.uppercased() == dato.uppercased(){
                        posicion = index
                        brandPickerView.selectRow(posicion, inComponent: 0, animated: true)
                    }
                }
            }
            if carGet!.origin != ""{
                for (index, dato) in nationalityPickerViewValues.enumerated(){
                    if carGet!.origin.uppercased() == dato.uppercased(){
                        posicion = index
                        nationalityPickerView.selectRow(posicion, inComponent: 0, animated: true)
                    }
                }
            }
            if carGet!.colorPlate != ""{
                for (index, dato) in colorPickerViewValues.enumerated(){
                    if carGet!.colorPlate.uppercased() == dato.uppercased(){
                        posicion = index
                        colorPickerView.selectRow(posicion, inComponent: 0, animated: true)
                    }
                }
            }
            if carGet!.leftPressureTireFront != ""{
                for(index, dato) in Array(tirePressureValues).enumerated(){
                    if carGet!.leftPressureTireFront.prefix(2) == String(dato){
                        posicion = index
                        tireUpLeftPickerView.selectRow(posicion, inComponent: 0, animated: true)
                    }
                }
            }
            if carGet!.rightPressureTireFront != ""{
                for(index, dato) in Array(tirePressureValues).enumerated(){
                    if carGet!.rightPressureTireFront.prefix(2) == String(dato){
                        posicion = index
                        tireUpRightPickerView.selectRow(posicion, inComponent: 0, animated: true)
                    }
                }
            }
            if carGet!.leftPressureTireBehavior != ""{
                for(index, dato) in Array(tirePressureValues).enumerated(){
                    if carGet!.leftPressureTireBehavior.prefix(2) == String(dato){
                        posicion = index
                        tireDownLeftPicker.selectRow(posicion, inComponent: 0, animated: true)
                    }
                }
            }
            if carGet!.rightPressureTireBehavior != ""{
                for(index, dato) in Array(tirePressureValues).enumerated(){
                    if carGet!.rightPressureTireBehavior.prefix(2) == String(dato){
                        posicion = index
                        tireDownRightPicker.selectRow(posicion, inComponent: 0, animated: true)
                    }
                }
            }
            cancelCarButton.isHidden = false
            saveEditCarButton.isHidden = false
           // print(String(carGet!.leftPressureTireFront.prefix(2)))
            
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         let tirePressurePickerViewValues = Array(tirePressureValues)
        switch pickerView.tag{
        case 1: return brandPickerViewValues.count
        case 2: return nationalityPickerViewValues.count
        case 3: return colorPickerViewValues.count
        case 4: return tirePressurePickerViewValues.count
        case 5: return tirePressurePickerViewValues.count
        case 6: return tirePressurePickerViewValues.count
        case 7: return tirePressurePickerViewValues.count
        default:
            return 0
        }
        
        
    }
  
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         let tirePressurePickerViewValues = Array(tirePressureValues)
        
        switch pickerView.tag{
        case 1:
           // carSend?.brand = brandPickerViewValues[row]
            return brandPickerViewValues[row]
        case 2:
           // carSend?.origin = brandPickerViewValues[row]
            return nationalityPickerViewValues[row]
        case 3:
            //carSend?.colorPlate = brandPickerViewValues[row]
            return colorPickerViewValues[row]
        case 4:
            //carSend?.leftPressureTireFront = brandPickerViewValues[row]
            return String(tirePressurePickerViewValues[row])
        case 5:
            //carSend?.rightPressureTireFront = brandPickerViewValues[row]
            return String(tirePressurePickerViewValues[row])
        case 6:
           // carSend?.leftPressureTireBehavior = brandPickerViewValues[row]
            return String(tirePressurePickerViewValues[row])
        case 7:
           // carSend?.rightPressureTireFront = brandPickerViewValues[row]
            return String(tirePressurePickerViewValues[row])
        default:
            return "0"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //obtener el dato
        let tirePressurePickerViewValues = Array(tirePressureValues)
        var rowChoose : String
       switch pickerView.tag{
       case 1 :
            carSend?.brand = brandPickerViewValues[row]
            rowChoose = brandPickerViewValues[row]
            print(rowChoose)
       case 2:
           carSend?.origin = nationalityPickerViewValues[row]
           rowChoose = nationalityPickerViewValues[row]
           print(rowChoose)
       case 3:
           carSend?.colorPlate = colorPickerViewValues[row]
           rowChoose = colorPickerViewValues[row]
           print(rowChoose)
       case 4:
           carSend?.leftPressureTireFront = String(tirePressurePickerViewValues[row])
           rowChoose = String(tirePressurePickerViewValues[row])
           print(rowChoose)
       case 5:
           carSend?.rightPressureTireFront = String(tirePressurePickerViewValues[row])
           rowChoose = String(tirePressurePickerViewValues[row])
           print(rowChoose)
       case 6:
           carSend?.leftPressureTireBehavior = String(tirePressurePickerViewValues[row])
           rowChoose = String(tirePressurePickerViewValues[row])
           print(rowChoose)
       case 7:
           carSend?.rightPressureTireFront = String(tirePressurePickerViewValues[row])
           rowChoose = String(tirePressurePickerViewValues[row])
           print(rowChoose)
       default:
            "0"
       }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        plateTextField.resignFirstResponder()
    }
    /*func textFieldDidEndEditing(_ textField: UITextField) {
        //Obtener el dato de aqui del campo
    }*/

    
    
    @IBAction func SaveAddCarButton(_ sender: Any) {
        print("Agregando...")
        //Por identificador en el segue
      //  performSegue(withIdentifier: "IdentificadorSegue", sender: self)
    }
    
    @IBAction func saveEditCarButton(_ sender: Any) {
        print("Editando...")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! CarListViewController
        
        destination.carNew?.brand = carSend!.brand
        destination.carNew?.origin = carSend!.origin
        destination.carNew?.colorPlate = carSend!.colorPlate
        destination.carNew?.licensePlate = carSend!.licensePlate
        destination.carNew?.leftPressureTireFront = carSend!.leftPressureTireFront
        destination.carNew?.rightPressureTireFront = carSend!.rightPressureTireFront
        destination.carNew?.leftPressureTireBehavior = carSend!.leftPressureTireBehavior
        destination.carNew?.rightPressureTireBehavior = carSend!.rightPressureTireBehavior
        destination.carNew?.image = carSend!.image
        
        
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
        let isModal = self.presentingViewController is UINavigationController
        if isModal{
            self.dismiss(animated: true)
        }
        else{
            navigationController?.popViewController(animated: true)
        }
    }
 
    @IBAction func cancelAddCarButton(_ sender: Any) {
        self.dismiss(animated: true)
        let isModal = self.presentingViewController is UINavigationController
        if isModal{
            self.dismiss(animated: true)
        }
        else{
            navigationController?.popViewController(animated: true)
        }
    }
}



