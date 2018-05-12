//
//  RoadTableViewCell.swift
//  MajorRoads
//
//  Created by Cerebro on 12/05/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import UIKit

class RoadTableViewCell: UITableViewCell {
    
    var road:Road?
    
    @IBOutlet weak var statusSeverityLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favouriteImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(){
        nameLabel.text = road?.name
        statusSeverityLabel.text = road?.severity
    }
    
    override func prepareForReuse() {
        nameLabel.text = ""
        statusSeverityLabel.text = ""
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
