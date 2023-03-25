//
//  CredentialDetailViewController.swift
//  AutoAcuerdate
//
//  Created by DISMOV on 24/03/23.
//

import UIKit

class CredentialDetailViewController: UIViewController {

    @IBOutlet weak var nationLabel: UILabel!
    @IBOutlet weak var vigencyAlertLabel: UILabel!
    @IBOutlet weak var expDateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var itinLabel: UILabel!
    var cardSend : CirculationCard?
    var cardView : CirculationCard?
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
            guard let laURL = URL(string: "https://private-f5db4f-luisoctaviogomezdelacruzluocz.apiary-mock.com/cards?id_car\(String(cardSend!.idCard))") else { return }
            print(laURL)
            
            do {
                let bytes = try Data(contentsOf: laURL)
                let card = try? JSONDecoder().decode(CirculationCard.self, from: bytes)
                cardView = card
            } catch {
                print("Error al descargar el JSON " + String(describing: error))
            }
            nameLabel.text = cardView?.name ?? "UNKNOWED"
            itinLabel.text = "itin: \(cardView?.itin ?? "itin: ")"
            expDateLabel.text = cardView?.expDate ?? ""
            vigencyAlertLabel.text = cardView?.efeDate ?? ""
            nationLabel.text = cardView?.origin ?? ""
        }
    }
    

    

}
