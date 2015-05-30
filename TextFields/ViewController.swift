//
//  ViewController.swift
//  TextFields
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    // MARK: -
    // MARK: Outlets

    @IBOutlet private weak var textField1: UITextField!
    @IBOutlet private weak var textField2: UITextField!
    @IBOutlet private weak var textField3: UITextField!
    @IBOutlet private weak var editSwitch: UISwitch!

    // MARK: Delegates

    private let zipDelegate = ZipTextFieldDelegate()
    private let cashDelegate = CashTextFieldDelegate()

    // MARK: -
    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField1.delegate = zipDelegate
        self.textField2.delegate = cashDelegate
        self.textField3.delegate = self

        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        self.textField2.placeholder = formatter.stringFromNumber(NSNumber(integer: 0))
    }

    // MARK: -
    // MARK: UITextFieldDelegate Methods

    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return editSwitch.on
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func toggleEditing(sender: UISwitch) {
        if !sender.on {
            textField3.resignFirstResponder()
        }
    }

}
