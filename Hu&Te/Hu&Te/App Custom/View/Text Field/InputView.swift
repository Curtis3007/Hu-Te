//
//  InputView.swift
//  Hu&Te
//
//  Created by BigSur on 20/05/2021.
//

import Foundation
import UIKit

class InputView: BaseViewXib {
    @IBOutlet weak var textField: UITextField!
    override func setUpViews() {
        
    }
    
    func setupData(title: String){
        textField.placeholder = title
    }
}
