//
//  ViewController.swift
//  NotificationCenter0
//
//  Created by Cenker Soyak on 28.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = Timer()
    var counter = 15
    let timeLabel = UILabel()
    let passwordTextfield = UITextField()
    let decryptButton = UIButton()
    let checkButton = UIButton()
    var secretMessage = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        NotificationCenter.default.addObserver(self, selector: #selector(decodeData), name: Notification.Name("MyNotification"), object: nil)
    }
    
    func createUI(){
        view.backgroundColor = .systemBlue
        
        timeLabel.text = "Time: \(counter)"
        timeLabel.textColor = .white
        timeLabel.textAlignment = .center
        timeLabel.font = .systemFont(ofSize: 20)
        view.addSubview(timeLabel)
        timeLabel.frame = CGRect(x: 155, y: 140, width: 90, height: 30)
        
        passwordTextfield.placeholder = "Type the password:"
        passwordTextfield.textAlignment = .center
        passwordTextfield.backgroundColor = .white
        passwordTextfield.borderStyle = .roundedRect
        view.addSubview(passwordTextfield)
        passwordTextfield.frame = CGRect(x: 100, y: 200, width: 200, height: 40)
        
        decryptButton.setTitle("Decrypt", for: UIControl.State.normal)
        decryptButton.setTitleColor(.white, for: UIControl.State.normal)
        decryptButton.backgroundColor = .black
        view.addSubview(decryptButton)
        decryptButton.frame = CGRect(x: 130, y: 600, width: 130, height: 30)
        decryptButton.addTarget(self, action: #selector(decryptButtonClicked), for: .touchUpInside)
        
        checkButton.setTitle("Check", for: UIControl.State.normal)
        checkButton.setTitleColor(.white, for: UIControl.State.highlighted)
        checkButton.backgroundColor = .darkGray
        view.addSubview(checkButton)
        checkButton.frame = CGRect(x: 130, y: 400, width: 130, height: 30)
        checkButton.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
        }
    @objc func decryptButtonClicked(){
        decryptButton.isUserInteractionEnabled = false
        segue()
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerLogic), userInfo: nil, repeats: true)
    }
    
    @objc func checkButtonClicked(){
        if passwordTextfield.text == "\(secretMessage)" {
            alert(title: "Decryption Completed", message: "You've successfully completed the task. ")
        } else {
            alert(title: "Decryption Failed", message: "You've ruined everything..")
        }
    }
    
    func segue() {
        let controller = SecondViewController()
        controller.modalPresentationStyle = .fullScreen
        present(controller,animated: true)
    }
    
    @objc func decodeData(data: Notification){
        if let userData = data.userInfo{
            secretMessage = userData["password"] as! Int
            print(secretMessage)
        
        }
    }
    
    @objc func timerLogic () {
        timeLabel.text = "Time: \(counter)"
        counter -= 1
        
        if counter == 0{
            timer.invalidate()
            alert(title: "Time is up", message: "")
        }
    }
    
    func alert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let button = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(button)
        present(alert, animated: true)
    }
}
