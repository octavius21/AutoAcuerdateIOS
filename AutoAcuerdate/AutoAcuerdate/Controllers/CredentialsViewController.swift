//
//  CredentialsViewController.swift
//  AutoAcuerdate
//
//  Created by DISMOV on 22/03/23.
//

import UIKit

class CredentialsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var cardNew: CirculationCard?
    var objectsCards = [CirculationCard]()
    var cardSend: CirculationCard?
    var rowIndex: Int?
    private let cellWidth = UIScreen.main.bounds.width/2.2
    @IBOutlet var CredentialsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        CredentialsCollectionView.register(UINib(nibName: "CardItemCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "cardCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        if !InternetMonitor.instance.internetStatus{
            let alert = UIAlertController(title: "Need it Internet Conection", message: "This App need it Internet for used", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (okSelected) -> Void in
                self.dismiss(animated: true)
            }
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }else{
            // Consultar el API y serializar el JSON
            guard let laURL = URL(string: "https://private-f5db4f-luisoctaviogomezdelacruzluocz.apiary-mock.com/cards") else { return }
            
            do {
                let bytes = try Data(contentsOf: laURL)
                let cards = try? JSONDecoder().decode(Card.self, from: bytes)
                objectsCards = cards!.circulationCards
                self.collectionView.reloadData()
            } catch {
                print("Error al descargar el JSON " + String(describing: error))
            }
        }
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objectsCards.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as? CardItemCollectionViewCell
        cardNew = objectsCards[indexPath.row]
        
        cell?.nameLabel.text = cardNew?.name
        cell?.itinLabel.text = "itin: \(cardNew!.itin)"
        cell?.expeditionLabel.text = cardNew?.expDate
        cell?.vigencyLabel.text = cardNew?.efeDate
        cell?.nationalityLabel.text = cardNew?.origin
        cell?.editButton.tag = indexPath.row
        cell?.editButton.addTarget(self, action: #selector(rowBtnWasTapped(sender: )), for: .touchUpInside)
        return cell!
    }
    @objc
    func rowBtnWasTapped(sender: UIButton){
        rowIndex = sender.tag
        performSegue(withIdentifier: "showEditCard", sender: self)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cardNew = objectsCards[indexPath.row]
        performSegue(withIdentifier: "showCard", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCard"{
            let destination = segue.destination as!
            CredentialDetailViewController
            destination.cardSend = cardNew
        }
        if segue.identifier == "showEditCard"{
            let destination = segue.destination as! AddCredentialViewController
            destination.cardRowSend = rowIndex!
            print(objectsCards[rowIndex!].name)
            destination.cardGet = objectsCards[rowIndex!]
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellWidth)
    }
    


}
