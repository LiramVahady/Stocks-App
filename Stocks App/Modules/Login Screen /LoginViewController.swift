//
//  LoginViewController.swift
//  Stocks App
//
//  Created by liram vahadi on 09/03/2021.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet var textFields: [UIView]!
    @IBOutlet weak var loginButton: UIButton!
    
    //MARK: Properties
    var activityIndicatorView = UIActivityIndicatorView()
    private let userAuthentication = UserAuthenticationManagment()
    private let register = RegisterService()
    var emptyView = EmptyViewDuringLoadingData()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardDissmis()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        setGradientBackground()
        configurIconImage()
        navigationController?.setNavigationBarHidden(true, animated: animated)
        emptyView.hideEmptyView(stop: activityIndicatorView)
      
    }
    
    //MARK: Actions
    
    @IBAction func loginTapped(_ sender: Any) {
        
        if let _ = userloginAuthentication(){
        performSegue(withIdentifier: ConstantValues.SegueIdentifier.login, sender: nil)
        UserDefaultsManagement.saveUserSuccessLogin(true)
        return
        }
        
        appearDialogToUser(title: "Details Invalid", message: "Your Emaail or Password is not correct")
       
    }
    
    
    //TODO: renane function
    @IBAction func registerTapped(_ sender: Any) {
        
        let blurView = showBlurScreen()
        view.addSubview(blurView)
        
        register.createUser(with: self, blurView: blurView) { (email, password, repassword) in
            
            self.validUserDetails(email: email!, password: password!, repassword: repassword!)
        }
        
    }
    
    
    //MARK: Functions
    func setGradientBackground() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(named: "Color4")!.cgColor, UIColor(named: "launch")!.cgColor,]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
     func configurIconImage(){
        
        iconImageView.layer.cornerRadius = 20
        iconImageView.layer.borderWidth = 1
        iconImageView.layer.borderColor = UIColor.white.cgColor
        iconImageView.layer.masksToBounds = true

        iconImageView.clipsToBounds = true
        iconImageView.layer.cornerRadius = iconImageView.frame.size.height/2

        iconImageView.clipsToBounds = true
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = iconImageView.frame.size.height/2
        iconImageView.layer.borderWidth = 2
        iconImageView.layer.borderColor = UIColor(named: "Color4")?.cgColor
    }
    
    private func configureComponent(){
        textFields.forEach{$0.layer.cornerRadius = 20}
        loginButton.layer.cornerRadius = 20
    }
    
    private func showBlurScreen()-> UIView{
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return blurEffectView
    }
    
    private func validUserDetails(email: String, password: String, repassword: String){
        
        if userAuthentication.didEmaillExist(email){
            appearDialogToUser(title: "Email Already Exist", message: "You Already Registered")
            
        }else if !userAuthentication.isValidEmail(email){
            appearDialogToUser(title: "Invalid Email", message: "Please enter correct email")
            
        }else if !userAuthentication.isValidCountOfPassword(password){
            appearDialogToUser(title: "Invalid Password", message: "At least 5 chars")
            
        }else if !userAuthentication.isRepassValid(password, repassword){
            appearDialogToUser(title: "Invalid Password", message: "Password and Repassword are mot same")
            
        }else{
          appearDialogToUser(title: "Register has been Success", message: "Rgister Success 👍")
            userAuthentication.saveUserDetails(email: email, password: password)
        }
        
    }
    
    private func userloginAuthentication()-> Bool?{
        
        guard let email = UserDefaults.standard.string(forKey: userAuthentication.emailkey),
              let password = UserDefaults.standard.string(forKey: userAuthentication.passwordKey)
        else { return nil }
        
        if userAuthentication.didUserDetailsEquals(email, password){
            return true
        }
       
        return false
    }
    
}







