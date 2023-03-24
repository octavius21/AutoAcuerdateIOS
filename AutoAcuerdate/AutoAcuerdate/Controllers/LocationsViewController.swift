//
//  LocationsViewController.swift
//  AutoAcuerdate
//
//  Created by DISMOV on 22/03/23.
//

import UIKit

class LocationsViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    var locationNew: LocationElement?
    var objectsLocations = [LocationElement]()
    private let cellWidth = (UIScreen.main.bounds.width-2)/2.2
    @IBOutlet var locationsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationsCollectionView.register(UINib(nibName: "LocationItemCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "locationCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        
        // Consultar el API y serializar el JSON
        guard let laURL = URL(string: "https://private-f5db4f-luisoctaviogomezdelacruzluocz.apiary-mock.com/locations") else { return }
        
        do {
            let bytes = try Data(contentsOf: laURL)
            let locations = try? JSONDecoder().decode(Location.self, from: bytes)
            objectsLocations = locations!.location
            self.collectionView.reloadData()
        } catch {
            print("Error al descargar el JSON " + String(describing: error))
        }
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objectsLocations.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "locationCell", for: indexPath) as? LocationItemCollectionViewCell
        locationNew = objectsLocations[indexPath.row]
        
        cell?.locationNameLabel.text = locationNew?.locationName.capitalized
        cell?.addressLabel.text = locationNew?.address
        cell?.nationLabel.text = locationNew?.nation.uppercased()
        return cell!
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        locationNew = objectsLocations[indexPath.row]
       // performSegue(withIdentifier: "showCard", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       /* if segue.identifier == "showCard"{
            let detination = segue.destination as!
            CardDetailViewController
            
            destination.cardSend = cardNew
        }*/
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellWidth)
    }
    


}

