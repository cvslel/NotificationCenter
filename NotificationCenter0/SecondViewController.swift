//
//  SecondViewController.swift
//  NotificationCenter0
//
//  Created by Cenker Soyak on 28.09.2023.
//

import UIKit

class SecondViewController: UIViewController {

    let randomNumber = Int.random(in: 100000...999999)
    let vc = ViewController()
    let gobackButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.post(name: Notification.Name("MyNotification"), object: nil, userInfo: ["password": randomNumber])
        createUI()
    }
    
    func createUI(){
        view.backgroundColor = .blue

        let passLabel = UILabel()
        passLabel.text = String(randomNumber)
        vc.secretMessage = Int(randomNumber)
        print(vc.secretMessage)
        passLabel.textColor = .white
        passLabel.textAlignment = .center
        passLabel.font = .systemFont(ofSize: 20)
        view.addSubview(passLabel)
        passLabel.frame = CGRect(x: 147, y: 200, width: 100, height: 30)
        
        gobackButton.setTitle("Go Back", for: UIControl.State.normal)
        gobackButton.setTitleColor(.black, for: UIControl.State.normal)
        gobackButton.backgroundColor = .white
        view.addSubview(gobackButton)
        gobackButton.frame = CGRect(x: 20, y: 100, width: 70, height: 30)
        gobackButton.addTarget(self, action: #selector(gobackButtonClicked), for: .touchUpInside)
    }
    
    func timer(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0){
            self.vc.modalPresentationStyle = .fullScreen
            self.present(self.vc, animated: true)
            self.vc.startTimer()
        }
    }
    
    @objc func gobackButtonClicked(){
        timer()
    }
}
