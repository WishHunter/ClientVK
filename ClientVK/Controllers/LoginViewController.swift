//
//  LoginViewController.swift
//  ClientVK
//
//  Created by Denis Molkov on 16.02.2021.
//

import UIKit

@IBDesignable
class LoginViewController: UIViewController {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    //MARK: - Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // Присваиваем его UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
        style()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - keyboard func
    
    // Когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
        
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    //Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    
    //MARK: - Segue
    
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        guard identifier == "starterTabBarController" else {
//            let login = loginInput.text!
//            let password = passwordInput.text!
//            
//            if (login != "admin" || password != "admin") {
//                customAllert("Not correct login or password")
//                return false
//            }
//            return true
//        }
//        return true
//    }
}

//MARK: - Style

extension LoginViewController {
    func style() {
        background()
        logo()
        input()
        button()
    }
    
    func background() {
        let colorBottom =  UIColor(red: 113/255, green: 217/255, blue: 254/255, alpha: 1)
        let colorTop = UIColor(red: 64/255, green: 176/255, blue: 250/255, alpha: 1)
        let endY = 0.5 + view.frame.size.width / view.frame.size.height / 2
        
        self.view.addGradient(colorTop: colorTop, colorBottom: colorBottom, type: .radial, startPoint: CGPoint(x: 0.5, y: 0.5), endPoint: CGPoint(x: 1, y: endY))

        let imageLayer = UIImageView(frame: UIScreen.main.bounds)
        imageLayer.image = UIImage(named: "loginViewBg")
        imageLayer.contentMode = .scaleAspectFill

        imageLayer.frame = self.view.bounds

        self.view.insertSubview(imageLayer, at: 1)
    }
    
    func logo() {
        let logoLayer = logoImage.layer
        logoLayer.shadowColor = UIColor(red: 34/255.0, green: 139/255, blue: 201/255, alpha: 1).cgColor
        logoLayer.shadowOffset = CGSize(width: 4, height: 10)
        logoLayer.shadowRadius = CGFloat(26)
        logoLayer.shadowOpacity = 1
        logoLayer.masksToBounds = false
    }
    
    func input() {
        loginInput.addBottomBorder()
        passwordInput.addBottomBorder()
        
        let loginImageView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 17))
        let loginImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 17))
        loginImage.image = UIImage(named: "user")
        loginImageView.addSubview(loginImage)
        
        loginInput.leftView = loginImageView
        loginInput.leftViewMode = .always
        
        let passwordImageView = UIView(frame: CGRect(x: 0, y: 0, width: 23, height: 13))
        let passwordImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 13, height: 13))
        passwordImage.image = UIImage(named: "password")
        passwordImageView.addSubview(passwordImage)
        
        passwordInput.leftView = passwordImageView
        passwordInput.leftViewMode = .always
        
        let eyeImageView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 14))
        let eyeImage = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 14))
        eyeImage.image = UIImage(named: "eye")
        eyeImageView.addSubview(eyeImage)
        
        passwordInput.rightView = eyeImageView
        passwordInput.rightViewMode = .always
        
    }
    
    func button() {
        let bgColor =  UIColor(red: 242/255, green: 97/255, blue: 54/255, alpha: 1)
        let shadowColor =  UIColor(red: 215/255, green: 84/255, blue: 45/255, alpha: 1)
        
        loginButton.addShadow(to: [.bottom, .right], radius: 9.0, color: shadowColor)
        loginButton.backgroundColor = bgColor

        let button = loginButton.layer
        
//        let view = UIView(frame: CGRect(x: 0, y: -(loginButton.frame.height), width: loginButton.frame.width, height: loginButton.frame.height))
//
//        view.backgroundColor = .blue
//
//        view.layer.shadowColor = UIColor.blue.cgColor
//        view.layer.shadowOffset = CGSize(width: 0, height: 10)
//        view.layer.shadowOpacity = 1
//        view.layer.shadowRadius = CGFloat(9)
//
//        loginButton.addSubview(view)

        button.cornerRadius = 17
        button.borderWidth = 3
        button.borderColor = UIColor.white.cgColor
//        button.masksToBounds = true
    }
}

