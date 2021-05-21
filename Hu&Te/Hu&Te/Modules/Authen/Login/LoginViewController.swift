//
//  LoginViewController.swift
//  Hu&Te
//
//  Created BigSur on 20/05/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Edward
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var tfEmail: InputView!
    @IBOutlet weak var tfPassword: InputView!
    var presenter: LoginPresenterProtocol

	init(presenter: LoginPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "LoginViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
        super.viewDidLoad()

        presenter.view = self
        setupUI()
    }
    
    func setupUI(){
        navigationController?.isNavigationBarHidden = true
        tfEmail.setupData(title: "EMAIL")
        tfPassword.setupData(title: "PASSWORD")
        tfPassword.textField.isSecureTextEntry = true
    }

    @IBAction func onTapLogin(_ sender: Any) {
        print("Email: \(tfEmail.textField.text)")
        print("Email: \(tfPassword.textField.text)")
        presenter.login(email: tfEmail.textField.text ?? "", password: tfPassword.textField.text ?? "")
//        navigationController?.pushViewController(HomeViewController(presenter: HomePresenter()), animated: true)
    }
    
    @IBAction func onTapRegister(_ sender: Any) {
        navigationController?.pushViewController(RegisterViewController(presenter: RegisterPresenter()), animated: true)
    }
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
}

extension LoginViewController: LoginViewProtocol{
    func loginSuccess() {
        navigationController?.pushViewController(HomeViewController(presenter: HomePresenter()), animated: true)
    }
    
    func loginFailed(error: String) {
        showAlert("Login Failed", message: error)
    }
    
    
}
