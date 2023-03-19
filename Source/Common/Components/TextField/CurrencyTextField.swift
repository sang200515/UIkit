//
//  CurrencyTextField.swift
//  fptshop
//
//  Created by Trần Văn Dũng on 25/05/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class CurrencyTextField: UITextField {
    var decimal: Decimal { string.decimal / pow(10, Formatter.currency.maximumFractionDigits) }
    var maximum: Decimal = 999_999_999.99
    private var lastValue: String?
    var locale: Locale = .current {
        didSet {
            Formatter.currency.locale = locale
            sendActions(for: .editingChanged)
        }
    }
    override func willMove(toSuperview newSuperview: UIView?) {
        Formatter.currency.locale = locale
        Formatter.currency.currencySymbol = ""
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        keyboardType = .numberPad
        textAlignment = .left
        sendActions(for: .editingChanged)
    }
    override func deleteBackward() {
        text = string.digits.dropLast().string
        sendActions(for: .editingChanged)
    }
    @objc func editingChanged() {
        guard decimal <= maximum else {
            text = lastValue
            return
        }
        text = decimal.currency.trimmingCharacters(in: .whitespaces)
        lastValue = text
    }
}



private extension CurrencyTextField {
    var doubleValue: Double { (decimal as NSDecimalNumber).doubleValue }
}
private extension UITextField {
     var string: String { text ?? "" }
}
private extension NumberFormatter {
    convenience init(numberStyle: Style) {
        self.init()
        self.numberStyle = numberStyle
    }
}
private extension Formatter {
    static let currency: NumberFormatter = .init(numberStyle: .currency)
}
private extension StringProtocol where Self: RangeReplaceableCollection {
    var digits: Self { filter (\.isWholeNumber) }
}
private extension String {
    var decimal: Decimal { Decimal(string: digits) ?? 0 }
}
private extension Decimal {
    var currency: String { Formatter.currency.string(for: self) ?? "" }
}
private extension LosslessStringConvertible {
    var string: String { .init(self) }
}
