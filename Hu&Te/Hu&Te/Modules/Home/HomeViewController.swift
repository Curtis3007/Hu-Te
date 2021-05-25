//
//  HomeViewController.swift
//  Hu&Te
//
//  Created BigSur on 20/05/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Edward
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var lbSpeaker: UILabel!
    @IBOutlet weak var lbUser: UILabel!
    @IBOutlet weak var lbTemp: UILabel!
    @IBOutlet weak var lbHumid: UILabel!
    var presenter: HomePresenterProtocol
    var timer = Timer()
	init(presenter: HomePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "HomeViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.getTemperature()
        presenter.getHumidity()
        navigationController?.navigationBar.isHidden = true
        setupUI()
        print("Token: \(UserDefaultHelper.shared.accessToken ?? "No token") 123")
    }
    
    func setupUI(){
        lbUser.text = "Hi, " + (UserDefaultHelper.shared.userName ?? "Username")
        lbSpeaker.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(fetchData), userInfo: nil, repeats: true)
    }
    
    @objc func randomNum(){
        lbTemp.text = String(Int.random(in: 0...100)) + "°C"
        lbHumid.text = String(Int.random(in: 0...100)) + "%"
    }
    
    @objc func fetchData(){
        presenter.getTemperature()
        presenter.getHumidity()
    }
    
    @IBAction func onTapPofile(_ sender: Any) {
        navigationController?.pushViewController(ProfileViewController(presenter: ProfilePresenter()), animated: true)
    }
    
    @IBAction func onTapGraph(_ sender: Any) {
        
    }
    
    @IBAction func onTapSpeaker(_ sender: Any) {
        
    }
    
    @IBAction func onTapSettings(_ sender: Any) {
        navigationController?.pushViewController(SettingsViewController(presenter: SettingsPresenter()), animated: true)
    }
    
    @IBAction func onTapHistory(_ sender: Any) {
        
    }
}

extension HomeViewController: HomeViewProtocol{
    func getHumidSuccess() {
        lbHumid.text = (presenter.humid?.value ?? "") + "%"
    }
    
    func getHumidFailed(error: String) {
        lbHumid.text = "..."
        showAlert("Error", message: error)
    }
    
    func getTempSuccess() {
        lbTemp.text = (presenter.temperature?.value ?? "") + "°C"
    }
    
    func getTempFailed(error: String) {
        lbTemp.text = "..."
        showAlert("Error", message: error)
    }
    
    
}
