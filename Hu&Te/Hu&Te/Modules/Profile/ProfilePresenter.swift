//
//  ProfilePresenter.swift
//  Hu&Te
//
//  Created BigSur on 20/05/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Edward
//

import Foundation
import PKHUD

// MARK: View -
protocol ProfileViewProtocol: class {
    func getProfileSuccess()
    func getProfileFailed(error: String)
    func updateProfileSuccess()
    func updateProfileFailed(error: String)
}

// MARK: Presenter -
protocol ProfilePresenterProtocol: class {
	var view: ProfileViewProtocol? { get set }
    var user: UserEntity? {get set}
    func getProfile()
    func updateProfile(name: String, phone: String)
}

class ProfilePresenter: ProfilePresenterProtocol {
    var user: UserEntity?
    weak var view: ProfileViewProtocol?

    func getProfile(){
        HUD.show(.progress)
        Provider.shared.profileAPIService.getProfile(success: { [weak self] (user) in
            guard let user = user, let strSelf = self else { return }
            HUD.hide()
            if user.error == nil {
                strSelf.user = user
                strSelf.view?.getProfileSuccess()
            } else {
                strSelf.view?.getProfileFailed(error: user.error ?? "Something went wrong. Try again")
            }
            
        }) { (error) in
            HUD.hide()
            self.view?.getProfileFailed(error: error?.localizedDescription ?? "Something went wrong")
        }
    }
    
    func updateProfile(name: String, phone: String){
        HUD.show(.progress)
        Provider.shared.profileAPIService.updateProfile(name: name, phone: phone, success: { [weak self] (user) in
            guard let user = user, let strSelf = self else { return }
            HUD.hide()
            if user.error == nil {
                strSelf.user = user
                strSelf.view?.updateProfileSuccess()
            } else {
                strSelf.view?.updateProfileFailed(error: user.error ?? "Something went wrong. Try again")
            }
            
        }) { (error) in
            HUD.hide()
            self.view?.updateProfileFailed(error: error?.localizedDescription ?? "Something went wrong")
        }
    }
}
