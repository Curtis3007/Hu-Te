//
//  SettingViewController.swift
//  Hu&Te
//
//  Created by admin on 5/20/21.
//

import UIKit

enum SettingGroupType {
    case Limitation
    case SpeakerFrequency
    case None
}

class SettingViewController: UIViewController, SettingViewProtocol {
    @IBOutlet weak var tbSetting: UITableView!
    var presenter: SettingPresenterProtocol
    private let groupTypes: [SettingGroupType] = [.None,.Limitation, .SpeakerFrequency]
    
    init(presenter: SettingPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "SettingViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        setupTableView()
        // Do any additional setup after loading the view.
    }
    private func setupTableView() {
        tbSetting.registerXibFile(LimitationCell.self)
        tbSetting.registerXibFile(SpeakerCell.self)
        tbSetting.tableFooterView = UIView()
        tbSetting.dataSource = self
        tbSetting.delegate = self
        tbSetting.estimatedRowHeight = 200
    }
}
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch groupTypes[section] {
        case .Limitation:
            return 4
        case .SpeakerFrequency:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if groupTypes[indexPath.section] == .Limitation {
            let cell = tbSetting.dequeue(LimitationCell.self, for: indexPath)
            return cell
        } else {
            let cell = tbSetting.dequeue(SpeakerCell.self, for: indexPath)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = NormalHeaderView()
            headerView.setupValue(index: section)
            return headerView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if groupTypes[indexPath.section] == .SpeakerFrequency {
            return UITableView.automaticDimension
        }
        return 75
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch groupTypes[section] {
        case .None:
            return 130
        default:
            return 40
        }
    }
}
