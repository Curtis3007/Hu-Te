//
//  RegisterPresenter.swift
//  Hu&Te
//
//  Created BigSur on 20/05/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Edward
//

import Foundation

// MARK: View -
protocol RegisterViewProtocol: class {

}

// MARK: Presenter -
protocol RegisterPresenterProtocol: class {
	var view: RegisterViewProtocol? { get set }
    func viewDidLoad()
}

class RegisterPresenter: RegisterPresenterProtocol {

    weak var view: RegisterViewProtocol?

    func viewDidLoad() {

    }
}