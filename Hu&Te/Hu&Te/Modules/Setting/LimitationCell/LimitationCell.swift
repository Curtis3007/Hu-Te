//
//  LimitationCell.swift
//  Hu&Te
//
//  Created by admin on 5/20/21.
//

import UIKit

class LimitationCell: UITableViewCell {

    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func setupView() {
        vContent.layer.cornerRadius = self.vContent.frame.height/2
        vContent.layer.masksToBounds = true
    }
    
}
