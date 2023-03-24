//
//  CardItemCollectionViewCell.swift
//  AutoAcuerdate
//
//  Created by DISMOV on 23/03/23.
//

import UIKit

class CardItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var vigencyLabel: UILabel!
    @IBOutlet weak var expeditionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var itinLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
