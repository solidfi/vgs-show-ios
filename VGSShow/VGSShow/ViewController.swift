//
//  ViewController.swift
//  VGSShow
//
//  Copyright © 2022 Solid. All rights reserved.
//

import Foundation
import UIKit
import VGSShowSDK

class ViewController: UIViewController {

    @IBOutlet weak var txtVGSVaultID: UITextField!
    @IBOutlet weak var txtCardID: UITextField!
    @IBOutlet weak var txtVGSToken: UITextField!
    @IBOutlet weak var txtEnvironment: UITextField!
    
    @IBOutlet weak var stackViewCVVNo: UIStackView!
    @IBOutlet weak var stackViewCardNumber: UIStackView!
    @IBOutlet weak var stackViewCardExp: UIStackView!
    @IBOutlet var lblCVV: VGSLabel!
    @IBOutlet var lblCardNumber: VGSLabel!
    @IBOutlet var lblExpDate: VGSLabel!
    
    var path = ""
    var vgsVaultID = ""
    var vgsCardID = ""
    var vgsShowToken = ""
    var vgsEnvironmentType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "VGS Show Sample"
    }
    
    @IBAction func btnSubmitPress(_ sender: Any) {
        self.validateData()
    }
}

// MARK: - Textfield delegate method
extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtEnvironment {
            self.showEnvironmentActionSheet()
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtEnvironment {
            self.showEnvironmentActionSheet()
            return false
        } else {
            return true
        }
    }
}

extension ViewController {
    
    func configureVGS(vgsShowObj: VGSShow) {
        lblCVV = VGSLabel()
        lblCardNumber = VGSLabel()
        lblExpDate = VGSLabel()
        vgsShowObj.subscribe(lblCVV)
        vgsShowObj.subscribe(lblCardNumber)
        vgsShowObj.subscribe(lblExpDate)
        configureVGSUI(vgsShowObj: vgsShowObj)
    }
    
    func configureVGSUI(vgsShowObj: VGSShow) {
        let paddings = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
                
        let textColor = UIColor.white
        let borderColor = UIColor.clear
        let backgroundColor = UIColor.clear
        let cornerRadius: CGFloat = 6
        let placeholderColor = UIColor.white
        
        let textAlignment = NSTextAlignment.left
        let cardNoFont = UIFont.systemFont(ofSize: 16)
        let cvvFont = UIFont.systemFont(ofSize: 14)
        let expFont = UIFont.systemFont(ofSize: 14)

        // Set placeholder text. Placeholder will appear until revealed text will be set in VGSLabel
        lblCardNumber.placeholder = "**** **** **** ****"
        lblCardNumber.contentPath = "cardNumber"

            
        lblCVV.placeholder = "***"
        lblCVV.contentPath = "cvv"
        
        lblExpDate.placeholder = "***"
        lblExpDate.contentPath = "expiry"
        
        // Create regex object, split card number to XXXX-XXXX-XXXX-XXXX format.
        do {
            let cardNumberPattern = "(\\d{4})(\\d{4})(\\d{4})(\\d{4})"
            let template = "$1 $2 $3 $4"
            let regex = try NSRegularExpression(pattern: cardNumberPattern, options: [])
            
            // Add transformation regex to your label.
            lblCardNumber.addTransformationRegex(regex, template: template)
        } catch {
            assertionFailure("invalid regex, error: \(error)")
        }
        
        vgsShowObj.subscribedLabels.forEach {
            $0.textAlignment = textAlignment
            $0.textColor = textColor
            $0.paddings = paddings
            $0.borderColor = borderColor
            $0.backgroundColor = backgroundColor
            $0.layer.cornerRadius = cornerRadius
            $0.placeholderStyle.color = placeholderColor
            $0.placeholderStyle.textAlignment = textAlignment
            $0.delegate = self
        }
        
        lblCardNumber.placeholderStyle.font = cardNoFont
        lblCardNumber.font =  cardNoFont
        
        lblCVV.placeholderStyle.font = cvvFont
        lblCVV.font =  cvvFont

        lblExpDate.placeholderStyle.font = expFont
        lblExpDate.font =  expFont
        
        stackViewCVVNo.addArrangedSubview(lblCVV)
        stackViewCardNumber.addArrangedSubview(lblCardNumber)
        stackViewCardExp.addArrangedSubview(lblExpDate)
    }
}

// MARK: - Setup UI and Validation methods
extension ViewController {

    func showEnvironmentActionSheet() {
        self.view.endEditing(true)
        let alert = UIAlertController(title: "" , message: "Please select Environment", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Sandbox", style: .default , handler:{ (UIAlertAction)in
            self.txtEnvironment.text = "Sandbox"
        }))
        
        alert.addAction(UIAlertAction(title: "Live", style: .default , handler:{ (UIAlertAction)in
            self.txtEnvironment.text = "Live"
        }))

        self.present(alert, animated: true, completion: {
            })
    }
    
    func validateData() {
        if let cardID = txtCardID.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            self.vgsCardID = cardID
        }
        
        if let vgsToken = txtVGSToken.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            self.vgsShowToken = vgsToken
        }
        
        if let vaultID = txtVGSVaultID.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            self.vgsVaultID = vaultID
        }
        
        if let environment = txtEnvironment.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            self.vgsEnvironmentType = environment
        }
        
        if  vgsVaultID.isEmpty || vgsCardID.isEmpty || vgsShowToken.isEmpty || vgsEnvironmentType.isEmpty {
            let alert = UIAlertController(title: "", message: "All fields are mendatory", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            self.requestData()
        }
    }
}

// MARK: - VGS Show API Call
extension ViewController: VGSLabelDelegate {
    func requestData() {
        let environment = self.vgsEnvironmentType == "Sandbox" ? VGSEnvironment.sandbox : VGSEnvironment.live
        let vgsShowObj = VGSShow(id: self.vgsVaultID, environment: environment.rawValue)
        self.path = "/v1/card/\(self.vgsCardID)/show"

        configureVGS(vgsShowObj: vgsShowObj)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            vgsShowObj.customHeaders = ["sd-show-token": self.vgsShowToken]
            vgsShowObj.request(path: self.path,
                            method: .get) { (requestResult) in
                
                switch requestResult {
                    case .success(let code):
                        debugPrint("vgsshow success, code: \(code)")
                    case .failure(let code, let error):
                        debugPrint("vgsshow failed, code: \(code), error: \(String(describing: error))")
                }
            }
        }
    }
    
    // Track errors in labels.
    func labelRevealDataDidFail(_ label: VGSLabel, error: VGSShowError) {
        debugPrint("error \(error) in label with \(label.contentPath ?? "no path")")
    }
    
    // Track text changes in labels.
    func labelTextDidChange(_ label: VGSLabel) {
        debugPrint("labelTextDidChange")
    }
    
    // Track when text is copied from labels.
    func labelCopyTextDidFinish(_ label: VGSLabel, format: VGSLabel.CopyTextFormat) {
        UIView.animate(withDuration: 0.3) {
            debugPrint("labelCopyTextDidFinish")
        } completion: { _ in
            debugPrint("Label copy")
        }
    }
}

