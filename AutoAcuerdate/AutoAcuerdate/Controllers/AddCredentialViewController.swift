//
//  AddCredentialViewController.swift
//  AutoAcuerdate
//
//  Created by DISMOV on 24/03/23.
//

import UIKit

class AddCredentialViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var cancelEditCardButton: UIButton!
    @IBOutlet weak var saveEditCardButton: UIButton!
    @IBOutlet weak var itinTextField: UITextField!
    @IBOutlet weak var nationTextField: UITextField!
    @IBOutlet weak var vigencyDayTextField: UITextField!
    @IBOutlet weak var expDayTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    var cardSend: CirculationCard?
    var cardRowSend: Int?
    var cardGet: CirculationCard?
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
            nameTextField.delegate = self
            itinTextField.delegate = self
            expDayTextField.delegate = self
            vigencyDayTextField.delegate = self
            nationTextField.delegate = self
            if cardGet == nil{
                saveEditCardButton.isHidden = true
                cancelEditCardButton.isHidden = true
            }
            
        }
    }
    
    fileprivate func searchValues() {
        if(cardGet != nil){
            nameTextField.text = cardGet!.name ?? ""
            expDayTextField.text = cardGet!.expDate ?? ""
            vigencyDayTextField.text = cardGet!.efeDate ?? ""
            nationTextField.text = cardGet!.origin ?? ""
            itinTextField.text = cardGet!.itin ?? ""
            saveEditCardButton.isHidden = false
            cancelEditCardButton.isHidden = false
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchValues()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        expDayTextField.resignFirstResponder()
        nationTextField.resignFirstResponder()
        vigencyDayTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        return itinTextField.resignFirstResponder()

    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! CredentialsViewController
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
    @IBAction func SaveAddCarButton(_ sender: Any) {
        print("Agregando...")
        //Por identificador en el segue
        //performSegue(withIdentifier: "IdentificadorSegue", sender: self)
    }

 
    @IBAction func saveEditCarButton(_ sender: Any) {
        print("Editando...")
    }
    
    @IBAction func cancelEditCarButton(_ sender: Any) {
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
