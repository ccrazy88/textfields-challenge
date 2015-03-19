//
//  ZipTextFieldDelegate.swift
//  TextFields
//

import UIKit

class ZipTextFieldDelegate: NSObject, UITextFieldDelegate {

    // MARK: -
    // MARK: UITextFieldDelegate Methods

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // Prevent undo crash
        if range.location + range.length > (textField.text as NSString).length {
            return false
        }

        // Max length of 5
        let newText = (textField.text as NSString).stringByReplacingCharactersInRange(range, withString: string)
        if count(newText) > 5 {
            return false
        }

        // Digits only in input (or deletions)
        let digits = NSCharacterSet.decimalDigitCharacterSet()
        for character in string.unicodeScalars {
            if !digits.longCharacterIsMember(character.value) {
                return false
            }
        }

        return true
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
