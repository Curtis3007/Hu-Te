//
//  NavigationView.swift
//  Hu&Te
//
//  Created by BigSur on 20/05/2021.
//

import Foundation
import UIKit

class NavigationView: BaseViewXib {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbRightTitle: UILabel!
    var onTapRightButton: (()->Void)? = nil
    var onTapBack: (()->Void)? = nil
    override func setUpViews() {
        
    }
    
    func setupNavigation(title: String, rightTitle: String?){
        lbTitle.text = title
        if let rightTitle = rightTitle {
            lbRightTitle.isHidden = false
            lbRightTitle.text = rightTitle
        } else {
            lbRightTitle.isHidden = true
        }
    }
    
    @IBAction func onTapRightButton(_ sender: Any) {
        onTapRightButton?()
    }
    
    @IBAction func onTapBack(_ sender: Any) {
        onTapBack?()
    }
}
