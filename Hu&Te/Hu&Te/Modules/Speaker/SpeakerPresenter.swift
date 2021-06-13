//
//  SpeakerPresenter.swift
//  Hu&Te
//
//  Created BigSur on 08/06/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Edward
//

import Foundation

// MARK: View -
protocol SpeakerViewProtocol: class {

}

// MARK: Presenter -
protocol SpeakerPresenterProtocol: class {
	var view: SpeakerViewProtocol? { get set }
    func viewDidLoad()
}

class SpeakerPresenter: SpeakerPresenterProtocol {

    weak var view: SpeakerViewProtocol?

    func viewDidLoad() {

    }
}
