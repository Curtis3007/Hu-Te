//
//  HomePresenter.swift
//  Hu&Te
//
//  Created BigSur on 20/05/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Edward
//

import Foundation

// MARK: View -
protocol HomeViewProtocol: class {
    func getTempSuccess()
    func getTempFailed(error: String)
    func getHumidSuccess()
    func getHumidFailed(error: String)
    
    func getThresholdSuccess()
    func getThresholdFailed(error: String)
    
    func getKeyFailed(error: String)
    
    func getTempAndHumidSuccess()
    func getTempAndHumidFailed(error: String)
}

// MARK: Presenter -
protocol HomePresenterProtocol: class {
	var view: HomeViewProtocol? { get set }
    var temperature: AdafruitEntity? {get set}
    var humid: AdafruitEntity? {get set}
    var adafruit: AdafruitEntity? {get set}
    var threshold: ThresholdEntity? {get set}
    func getKey(completionHandler: @escaping (KeyEntity) -> Void)
    func getTempAndHumid()
    func getThreshold()
}

class HomePresenter: HomePresenterProtocol {
    var threshold: ThresholdEntity?
    
    var adafruit: AdafruitEntity?
    var humid: AdafruitEntity?
    var temperature: AdafruitEntity?
    
    weak var view: HomeViewProtocol?
    
    func getKey(completionHandler: @escaping (KeyEntity) -> Void) {
        let url = URL(string: "http://dadn.esp32thanhdanh.link")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
          if let error = error {
            self.view?.getKeyFailed(error: error.localizedDescription)
            return
          }
          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
            self.view?.getKeyFailed(error: "Get Key Failed!")
            return
          }

          if let data = data,
            let keyEntity = try? JSONDecoder().decode(KeyEntity.self, from: data) {
            completionHandler(keyEntity)
          }
        })
        task.resume()
      }
    
    func getTemperature(){
        Provider.shared.adafruitAPIService.getTemperature(success: { [weak self] (temp) in
            guard let strSelf = self else { return }
            if temp.count == 0 {
                strSelf.view?.getTempFailed(error: "Something went wrong")
                return
            }
            strSelf.temperature = temp[0]
            strSelf.view?.getTempSuccess()
        }) { (error) in
            self.view?.getTempFailed(error: error?.localizedDescription ?? "Something went wrong")
        }
    }
    
    func getHumidity(){
        Provider.shared.adafruitAPIService.getHumidity(success: { [weak self] (humid) in
            guard let strSelf = self else { return }
            if humid.count == 0 {
                strSelf.view?.getHumidFailed(error: "Something went wrong")
                return
            }
            strSelf.humid = humid[0]
            strSelf.view?.getHumidSuccess()
        }) { (error) in
            self.view?.getHumidFailed(error: error?.localizedDescription ?? "Something went wrong")
        }
    }
    
    func getTempAndHumid(){
        Provider.shared.adafruitAPIService.getTemAndHumid(success: { [weak self] (adafruit) in
            guard let strSelf = self else { return }
            if adafruit.count == 0 {
                strSelf.view?.getTempAndHumidFailed(error: "Something went wrong")
                return
            }
            strSelf.adafruit = adafruit[0]
            strSelf.view?.getTempAndHumidSuccess()
        }) { (error) in
            self.view?.getTempAndHumidFailed(error: error?.localizedDescription ?? "Something went wrong")
        }
    }
    
    func getThreshold(){
        Provider.shared.profileAPIService.getThreShold(success: { [weak self] (data) in
            guard let data = data, let strSelf = self else { return }
            if data.error == nil {
                strSelf.threshold = data
                strSelf.view?.getThresholdSuccess()
            } else {
                strSelf.view?.getThresholdFailed(error: data.error ?? "Something went wrong. Try again")
            }
        }) { (error) in
            self.view?.getThresholdFailed(error: error?.localizedDescription ?? "Something went wrong")
        }
    }
}
