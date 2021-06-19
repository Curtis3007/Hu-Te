//
//  SettingsPresenter.swift
//  Hu&Te
//
//  Created BigSur on 21/05/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Edward
//

import Foundation
import PKHUD

// MARK: View -
protocol SettingsViewProtocol: class {
    func getThresholdSuccess()
    func getThresholdFailed(error: String)
    
    func setThresholdSuccess()
    func setThresholdFailed(error: String)
}

// MARK: Presenter -
protocol SettingsPresenterProtocol: class {
	var view: SettingsViewProtocol? { get set }
    var threshold: ThresholdEntity? {get set}
    var temp: String {get set}
    var humid: String {get set}
    func getThreshold()
    func setThreshold()
}

class SettingsPresenter: SettingsPresenterProtocol {
    var temp: String = ""
    var humid: String = ""
    weak var view: SettingsViewProtocol?
    var threshold: ThresholdEntity?
    
    func getThreshold(){
        HUD.show(.progress)
        Provider.shared.profileAPIService.getThreShold(success: { [weak self] (data) in
            guard let data = data, let strSelf = self else { return }
            HUD.hide()
            if data.error == nil {
                strSelf.threshold = data
                strSelf.view?.getThresholdSuccess()
            } else {
                strSelf.view?.getThresholdFailed(error: data.error ?? "Something went wrong. Try again")
            }
        }) { (error) in
            HUD.hide()
            self.view?.getThresholdFailed(error: error?.localizedDescription ?? "Something went wrong")
        }
    }
    
    func setThreshold(){
        HUD.show(.progress)
        Provider.shared.profileAPIService.setThreShold(temp: temp, humid: humid, success: { [weak self] (data) in
            HUD.hide()
            guard let data = data, let strSelf = self else { return }
            if data.error == nil {
                strSelf.threshold = data
                strSelf.view?.setThresholdSuccess()
            } else {
                strSelf.view?.setThresholdFailed(error: data.error ?? "Something went wrong. Try again")
            }
        }) { (error) in
            HUD.hide()
            self.view?.setThresholdFailed(error: error?.localizedDescription ?? "Something went wrong")
        }
    }
}
