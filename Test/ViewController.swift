//
//  ViewController.swift
//  Test
//
//  Created by Ruslan Bagautdinov on 24.10.2021.
//

import SnapKit
import UIKit

final class ViewController: UIViewController {

    enum AlertMessage: String {
            case max = "Вы достигли максимального значения!"
            case min = "Вы достигли минимального значения!"
        }
    
    //properties

    private let topImage: UIImageView = {
        var imageView = UIImageView()
        var image : UIImage = UIImage(named:"appimage")!
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView = UIImageView(image: image)
        return imageView
    }()
    
    private let resultLable: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "Avenir", size: 70)
        label.textColor = UIColor.green
        return label
    }()
    
    private let resetButton: UIButton = {
        let buttonClean = UIButton(type: .system)
        buttonClean.backgroundColor = UIColor.orange
        buttonClean.setTitleColor(.white, for: .normal)
        buttonClean.layer.cornerRadius = 20
        buttonClean.setTitle("C", for: .normal)
        buttonClean.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        buttonClean.addTarget(self, action: #selector(tappedClean), for: .touchUpInside)
        return buttonClean
    }()
    
    private let increaseButton: UIButton = {
        let buttonUp = UIButton(type: .system)
        buttonUp.backgroundColor = UIColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
        buttonUp.setTitleColor(.white, for: .normal)
        buttonUp.layer.cornerRadius = 20
        buttonUp.setTitle("+", for: .normal)
        buttonUp.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        buttonUp.addTarget(self, action: #selector(tappedUp), for: .touchUpInside)
        return buttonUp
    }()

    private let decreaseButton: UIButton = {
        let buttonDown = UIButton(type: .system)
        buttonDown.backgroundColor = UIColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
        buttonDown.setTitleColor(.white, for: .normal)
        buttonDown.layer.cornerRadius = 20
        buttonDown.setTitle("−", for: .normal)
        buttonDown.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        buttonDown.addTarget(self, action: #selector(tappedDown), for: .touchUpInside)
        return buttonDown
    }()

    
    private var counter: Int = 0 {
        didSet {
            increaseButton.isEnabled = counter < 10
            decreaseButton.isEnabled = counter > -10
            resultLable.text = "\(counter)"
            
            if counter == 10 {
                showAlert(message: .max)
            } else if counter == -10 {
                showAlert(message: .min)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializ()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
    
//methods

private extension ViewController {

        func initializ() {
        addingSubview()
        makeConstraints()
        view.backgroundColor = UIColor.black
     
        func addingSubview() {
            view.addSubview(topImage)
            view.addSubview(resultLable)
            view.addSubview(resetButton)
            view.addSubview(increaseButton)
            view.addSubview(decreaseButton)
        }
        
        func makeConstraints() {
            
            topImage.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.bottom.equalTo(resultLable).inset(90)
                maker.width.equalTo(150)
                maker.height.equalTo(150)
            }
            
            resultLable.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.centerY.equalToSuperview().offset(40)
            }
                
            resetButton.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.top.equalTo(resultLable).inset(90)
                maker.width.equalTo(100)
                maker.height.equalTo(40)
            }
                
            increaseButton.snp.makeConstraints { maker in
                maker.leading.equalTo(resetButton).inset(110)
                maker.top.equalTo(resultLable).inset(90)
                maker.width.equalTo(100)
                maker.height.equalTo(40)
            }
                
            decreaseButton.snp.makeConstraints { maker in
                maker.trailing.equalTo(resetButton).inset(110)
                maker.top.equalTo(resultLable).inset(90)
                maker.width.equalTo(100)
                maker.height.equalTo(40)
            }
        }
    }
}

//alert

private extension ViewController {
    func showAlert(message: AlertMessage) {
        let alert = UIAlertController(title: "Внимание!", message: message.rawValue, preferredStyle: .alert)
        let OkButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(OkButton)
        present(alert, animated: true, completion: nil)
        let generatorWarning = UINotificationFeedbackGenerator()
            generatorWarning.notificationOccurred(.warning)
    }
}

//action

private extension ViewController {
    
    @objc private func tappedClean() {
        counter = 0
    }
        
    @objc private func tappedUp() {
        counter += 1
    }
        
    @objc private func tappedDown() {
        counter -= 1
    }
}
