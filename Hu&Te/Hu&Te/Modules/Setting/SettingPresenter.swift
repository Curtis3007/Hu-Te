//
//  SettingPresenter.swift
//  Hu&Te
//
//  Created by admin on 5/20/21.
//

import Foundation

// MARK: View -
protocol SettingViewProtocol: class {

}

// MARK: Presenter -
protocol SettingPresenterProtocol: class {
    var view: SettingViewProtocol? { get set }
    func viewDidLoad()
}

class SettingPresenter: SettingPresenterProtocol {

    weak var view: SettingViewProtocol?

    func viewDidLoad() {

    }
}
