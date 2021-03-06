//
//  GraphPresenter.swift
//  Hu&Te
//
//  Created BigSur on 21/05/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Edward
//

import Foundation
import Charts
import PKHUD

enum ChartType {
    case Temperature
    case Humidity
}
// MARK: View -
protocol GraphViewProtocol: class {
    func getDataSuccess()
    func getDataFailed(error: String)
}

// MARK: Presenter -
protocol GraphPresenterProtocol: class {
	var view: GraphViewProtocol? { get set }
//    var values: [AdafruitEntity] {get set}
    var chartData: [ChartDataEntry] {get set}
    var humidData: [ChartDataEntry] {get set}
    var  type: ChartType {get set}
    func fetchData()
    func setupChartData()
}

class GraphPresenter: GraphPresenterProtocol {
    var humidData: [ChartDataEntry] = []
    var type: ChartType = .Temperature
    var chartData: [ChartDataEntry] = []
    var values: [AdafruitEntity] = []
    weak var view: GraphViewProtocol?
    
    func fetchData(){
        let now = Date()
        let date = changeToSystemTimeZone(now, from: TimeZone(identifier: "UTC+00:00")!, to: TimeZone(abbreviation: "UTC+07:00")!)
        let iso8601DateFormatter = ISO8601DateFormatter()
        iso8601DateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let endTime = iso8601DateFormatter.string(from: date)
        let temp = String(endTime.prefix(11)) + "00:00:00+0000"
//        var startDate = temp.convertToDate()
//        startDate = changeToSystemTimeZone(startDate, from: TimeZone(identifier: "UTC+07:00")!, to: TimeZone(abbreviation: "GMT")!)
//        let startTime = iso8601DateFormatter.string(from: startDate)
        getValues(startTime: temp, endTime: endTime)
    }
    
    func getValues(startTime: String, endTime: String){
        HUD.show(.progress)
        Provider.shared.adafruitAPIService.getValueFromTo(startTime: startTime, endTime: endTime, success: { [weak self] (values) in
            HUD.hide()
            guard let strSelf = self else { return }
            if values.count == 0 {
                strSelf.view?.getDataFailed(error: "Something went wrong")
                return
            }
            strSelf.values = values
            strSelf.values.reverse()
            strSelf.setupChartData()
            
        }) { (error) in
            HUD.hide()
            self.view?.getDataFailed(error: error?.localizedDescription ?? "Something went wrong")
        }
    }
    
    func setupChartData(){
        chartData.removeAll()
        if (type == .Temperature) {
            for value in values {
                chartData.append(ChartDataEntry(x: Double(value.timeInDay), y:  Double(value.tempAndHumid?.temp ?? "") ?? 0))
                chartData.sort(by: { $0.x < $1.x })
            }
        } else {
            for value in values {
                chartData.append(ChartDataEntry(x: Double(value.timeInDay), y:  Double(value.tempAndHumid?.humid ?? "") ?? 0))
                chartData.sort(by: { $0.x < $1.x })
            }
        }
        view?.getDataSuccess()
    }
    
    func changeToSystemTimeZone(_ date: Date, from: TimeZone, to: TimeZone = TimeZone.current) -> Date {
        let sourceOffset = from.secondsFromGMT(for: date)
        let destinationOffset = to.secondsFromGMT(for: date)
        let timeInterval = TimeInterval(destinationOffset - sourceOffset)
        return Date(timeInterval: timeInterval, since: date)
    }
}
