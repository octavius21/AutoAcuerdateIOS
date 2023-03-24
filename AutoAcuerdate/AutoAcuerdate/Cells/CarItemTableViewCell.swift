//
//  CarItemTableViewCell.swift
//  AutoAcuerdate
//
//  Created by DISMOV on 23/03/23.
//

import UIKit

class CarItemTableViewCell: UITableViewCell {
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carBrandLabel: UILabel!
    @IBOutlet weak var carModelLabel: UILabel!
    @IBOutlet weak var colorPlateImageView: UIImageView!
    @IBOutlet weak var plateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
