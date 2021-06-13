//
//  InputView.swift
//  Hu&Te
//
//  Created by BigSur on 20/05/2021.
//

import Foundation
import UIKit

class InputView: BaseViewXib, UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    override func setUpViews() {
        textField.delegate = self
    }
    
    func setupData(title: String){
        textField.placeholder = title
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
        
    }
}
