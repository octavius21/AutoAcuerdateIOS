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
    
    private let brandPickerViewValues = ["Volskwagen","Toyota", "Seat", "Jeep", "Tesla"]
    private let nationalityPickerViewValues = ["EUA", "Mexico", "Aleman", "Italiano"]
    private let colorPickerViewValues = ["AMARILLO", "ROSA", "ROJO", "AZUL", "VERDE", "NONE"]
    private let tirePressureValues = 29...41
    var carSend : CarElement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            carSend?.brand = brandPickerViewValues[row]
            return brandPickerViewValues[row]
        case 2:
            carSend?.origin = brandPickerViewValues[row]
            return nationalityPickerViewValues[row]
        case 3:
            carSend?.colorPlate = brandPickerViewValues[row]
            return colorPickerViewValues[row]
        case 4:
            carSend?.leftPressureTireFront = brandPickerViewValues[row]
            return String(tirePressurePickerViewValues[row])
        case 5:
            carSend?.rightPressureTireFront = brandPickerViewValues[row]
            return String(tirePressurePickerViewValues[row])
        case 6:
            carSend?.leftPressureTireBehavior = brandPickerViewValues[row]
            return String(tirePressurePickerViewValues[row])
        case 7:
            carSend?.rightPressureTireFront = brandPickerViewValues[row]
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
           carSend?.origin = brandPickerViewValues[row]
           rowChoose = nationalityPickerViewValues[row]
           print(rowChoose)
       case 3:
           carSend?.colorPlate = brandPickerViewValues[row]
           rowChoose = colorPickerViewValues[row]
           print(rowChoose)
       case 4:
           carSend?.leftPressureTireFront = brandPickerViewValues[row]
           rowChoose = String(tirePressurePickerViewValues[row])
           print(rowChoose)
       case 5:
           carSend?.rightPressureTireFront = brandPickerViewValues[row]
           rowChoose = String(tirePressurePickerViewValues[row])
           print(rowChoose)
       case 6:
           carSend?.leftPressureTireBehavior = brandPickerViewValues[row]
           rowChoose = String(tirePressurePickerViewValues[row])
           print(rowChoose)
       case 7:
           carSend?.rightPressureTireFront = brandPickerViewValues[row]
           rowChoose = String(tirePressurePickerViewValues[row])
           print(rowChoose)
       default:
            "0"
       }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        plateTextField.resignFirstResponder()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Obtener el dato de aqui del campo
    }

    
    
    @IBAction func SaveAddCarButton(_ sender: Any) {
        print("Guadnando...")
        //Por identificador en el segue
        performSegue(withIdentifier: "IdentificadorSegue", sender: self)
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
 
}



