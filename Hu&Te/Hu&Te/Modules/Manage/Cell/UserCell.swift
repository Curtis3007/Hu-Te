//
//  UserCell.swift
//  Hu&Te
//
//  Created by BigSur on 05/06/2021.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    var onTapDelete: (()->Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func onTapDelete(_ sender: Any) {
        onTapDelete?()
    }
    
    func setupData(user: UserEntity) {
        lbName.text = user.name
        lbEmail.text = user.email
        lbPhone.text = user.phone
    }
}
