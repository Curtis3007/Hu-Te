//
//  NormalHeaderView.swift
//  Hu&Te
//
//  Created by admin on 5/20/21.
//

import UIKit

class NormalHeaderView: BaseViewXib {
    @IBOutlet weak var imvSetting: UIImageView!
    @IBOutlet weak var lbHeaderTitle: UILabel!
    
    override func setUpViews() {
        super.setUpViews()
    }
    
    func setupValue(index: Int) {
        if index == 0 {
            lbHeaderTitle.isHidden = true
            imvSetting.isHidden = false
        } else {
            lbHeaderTitle.text = index == 1 ? "Limitation Setting" : "Speaker Frequency"
            lbHeaderTitle.isHidden = false
            imvSetting.isHidden = true
        }
    }
}
