//
//  BaseViewController.swift
//  NovelBooks
//
//  Created by BigSur on 09/05/2021.
//

import Foundation
import UIKit

enum StyleNavigation {
    case left
    case right
}

class BaseViewControllers: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    var backTapped : (() -> Void)? = nil
    var isUseHamburgerButton: Bool = false {
        didSet {
            if isUseHamburgerButton {
                //addSideMenuHamburgerButton()
            }
        }
    }
    
    //let vBadge = BadgeView(image: AppImage.Calendar_Gray)

    let whiteView: UIView = {
          let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //addBackToNavigation(icon: <#UIImage#>)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        //vBadge.addTapGesture(target: self, action: #selector(moveToMyBooking))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
//    func addBadgeViewNaviBar() {
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: vBadge)
//    }
    
//    func addSideMenuHamburgerButton() {
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "hamburger_sideMenu"), style: .plain, target: self, action: #selector(presentLeftMenuViewController(_:)))
//        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9803921569, green: 0.7098039216, blue: 0.1098039216, alpha: 1)
//    }
    
    func addBackToNavigation(icon: UIImage) {
        addButtonImageToNavigation(image: icon, style: .left)
    }
    
    func addButtonImageToNavigation(image: UIImage, style: StyleNavigation) {
//        showNavigation(bottomLine: false)
        let btn = UIButton()
        btn.setImage(image, for: .normal)
//        if let _action = action {
//            btn.addTarget(self, action: _action, for: .touchUpInside)
//        }
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.adjustsImageWhenHighlighted = false
        let button = UIBarButtonItem(customView: btn)
        if style == .left {
            btn.imageEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 20)
            btn.contentHorizontalAlignment = .left
            self.navigationItem.leftBarButtonItem = button
        } else {
            btn.imageEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 0)
            self.navigationItem.rightBarButtonItem = button
            btn.contentHorizontalAlignment = .right
        }
    }
    
//    @objc func moveToNotifycation() {
//        tabBarController?.navigationController?.pushViewController(factory.makeNewNotificationVC(), animated: true)
//        navigationController?.hidesBottomBarWhenPushed = true
//    }
    
    func addButtonToNavigation(title: String, style: StyleNavigation, action: Selector?, backgroundColor: UIColor = UIColor.white, textColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont = UIFont(name: "", size: 16)!, cornerRadius: CGFloat = 0, size: CGSize = CGSize(width: 20, height: 10), borderWidth: Double = 0, borderColor: UIColor = .clear){
        let btnRight = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 44))
        if let _action = action {
          btnRight.addTarget(self, action: _action, for: .touchUpInside)
        }
        btnRight.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        btnRight.layer.cornerRadius = cornerRadius
        btnRight.backgroundColor = backgroundColor
        btnRight.borderWidth = borderWidth
        btnRight.borderColor = borderColor
        btnRight.contentHorizontalAlignment = .center
      //    btnRight.setAttributed(title: title, color: textColor, font: font)
        btnRight.setTitleColor(textColor, for: .normal)
        btnRight.setTitle(title, for: .normal)
        btnRight.titleLabel?.font = font
        btnRight.backgroundColor = .clear
        let button = UIBarButtonItem(customView: btnRight)
        if style == .left {
          self.navigationItem.leftBarButtonItem = button
        } else {
          self.navigationItem.rightBarButtonItem = button
        }
      }
    
    func setNavigationTitle(title: String) {
        self.title = title
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
             NSAttributedString.Key.font: ""]
    }
    
    func hideBackButtonNavigaBar() {
        navigationController?.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func showNavigation(bottomLine: Bool = true) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        if bottomLine {
//            self.navigationController?.showShadowLine(color: AppColor.YellowFAB51C)
        } else {
            //self.navigationController?.hideShadowLine()
        }
    }
    
//    @objc func moveToMyBooking() {
//        tabBarController?.navigationController?.pushViewController(factory.makeMyBookingVC(), animated: true)
//        navigationController?.hidesBottomBarWhenPushed = true
//    }
    
    @objc func btnBackTapped() {
        if let complete = self.backTapped {
            complete()
        }
        self.navigationController?.popViewController(animated: true)
    }
//    func pushTo(_ viewController: UIViewController? = QRScanerViewController(presenter: QRScanerPresenter(type: .MakeBooking)), animated: Bool = true) {
//        navigationController?.pushViewController(viewController!, animated: animated)
//    }
    
    func popTo(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        self.dismissKeyboard()
//    }
    
//    func showActivityIndicator(){
//        DispatchQueue.main.async {
//            self.dismissKeyboard()
//            //if let window = UIApplication.shared.keyWindow {
//            self.view.addSubview(self.whiteView)
//            self.whiteView.fillSuperview()
//            HUD.show(.progress)
//            //}
//        }
//    }
    func transparentNav(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
}

extension UINavigationController
{
//    func showShadowLine(color:UIColor)
//    {
//        navigationBar.setValue(false, forKey: "hidesShadow")
//        navigationBar.shadowImage = color.as1ptImage()
//    }
//
//    func hideShadowLine() {
//        navigationBar.setValue(true, forKey: "hidesShadow")
//    }
}
extension BaseViewControllers {
    func dismissKeyBoard() {
        self.view.endEditing(true)
    }
}

