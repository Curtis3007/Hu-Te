//
//  LoginPresenter.swift
//  Hu&Te
//
//  Created BigSur on 20/05/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Edward
//

import Foundation

// MARK: View -
protocol LoginViewProtocol: class {

}

// MARK: Presenter -
protocol LoginPresenterProtocol: class {
	var view: LoginViewProtocol? { get set }
    func viewDidLoad()
}

class LoginPresenter: LoginPresenterProtocol {

    weak var view: LoginViewProtocol?

    func viewDidLoad() {

    }
}
