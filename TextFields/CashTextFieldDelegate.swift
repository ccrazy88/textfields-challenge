//
//  CashTextFieldDelegate.swift
//  TextFields
//

import UIKit

class CashTextFieldDelegate: NSObject, UITextFieldDelegate {

    // MARK: -
    // MARK: Properties

    private lazy var formatter: NSNumberFormatter = {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        return formatter
    }()

    // MARK: -
    // MARK: UITextFieldDelegate Methods

    // DISCLAIMERS:
    // - Setting the textField's text property moves the cursor to the end of the string
    // - Only works on currencies that have a unit (i.e. dollars) with 100 subunits (i.e. cents)
    // - Limits final string to a maximum of 15 characters

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // Prevent undo crash
        if range.location + range.length > (textField.text as NSString).length {
            return false
        }

        let newText = (textField.text as NSString).stringByReplacingCharactersInRange(range, withString: string)

        // Digits only in input (or deletions)
        let digits = NSCharacterSet.decimalDigitCharacterSet()
        for character in string.unicodeScalars {
            if !digits.longCharacterIsMember(character.value) {
                return false
            }
        }

        // Gather all digits
        var newTextDigits = ""
        for character in newText.unicodeScalars {
            if digits.longCharacterIsMember(character.value) {
                newTextDigits.append(character)
            }
        }

        // Format all digits into a currency string
        let cents = NSDecimalNumber(string: newTextDigits)
        if cents == NSDecimalNumber.notANumber() {
            textField.text = formatter.stringFromNumber(NSNumber(integer: 0))
        } else {
            let dollars = cents.decimalNumberByDividingBy(100)
            let proposedText = formatter.stringFromNumber(dollars)
            if let proposedText = proposedText {
                if count(proposedText) > 15 {
                    return false
                }
            }
            textField.text = proposedText
        }

        return false
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text.isEmpty {
            textField.text = formatter.stringFromNumber(NSNumber(integer: 0))
        }
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
