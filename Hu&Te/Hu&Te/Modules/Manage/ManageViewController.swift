//
//  ManageViewController.swift
//  Hu&Te
//
//  Created BigSur on 05/06/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Edward
//

import UIKit

class ManageViewController: UIViewController {

    @IBOutlet weak var vNavigation: NavigationView!
    @IBOutlet weak var tableView: UITableView!
    var presenter: ManagePresenterProtocol

	init(presenter: ManagePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "ManageViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getUsers()
        presenter.view = self
        setupUI()
    }
    
    func setupUI(){
        //navigationController?.navigationBar.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerXibFile(UserCell.self)
    }

}

extension ManageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(UserCell.self)
        cell.setupData(user: presenter.users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ManageHeader()
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 34
    }
}

extension ManageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ManageViewController: ManageViewProtocol {
    func getUsersSuccess() {
        tableView.reloadData()
    }
    
    func getUsersFailed(error: String) {
        showAlert("Error", message: error)
    }
}
