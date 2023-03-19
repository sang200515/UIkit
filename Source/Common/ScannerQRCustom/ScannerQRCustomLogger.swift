//
//  ScannerQRCustomLogger.swift
//  fptshop
//
//  Created by KhanhNguyen on 10/26/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation

class ScannerQRCustomLogger {

    private enum LogType: String {

        case error
        case warning
        case success

        var header: String {
            switch self {
            case .success:
                return "✅ Success occured"
            case .warning:
                return "⚠️ Warning occured"
            case .error:
                return "❌ Error occured"
            }
        }
    }

    private static func show(_ logType: LogType, function: String, file: String, line: Int, message: String) {

        #if DEBUG
            let fileName = file.components(separatedBy: "/").last ?? "Could not detect file"

            let msg = logType.header
                + "\n   function: \(function)"
                + "\n   file: \(fileName)"
                + "\n   line: \(line)"
                + "\n   message: \(message)"
            print(msg)
        #endif
    }

    static func error(_ function: String = #function, file: String = #file, line: Int = #line, message: String = "No message") {

        show(.error, function: function, file: file, line: line, message: message)
    }

    static func warning(_ function: String = #function, file: String = #file, line: Int = #line, message: String = "No message") {

        show(.warning, function: function, file: file, line: line, message: message)
    }

    static func success(_ function: String = #function, file: String = #file, line: Int = #line, message: String = "No message") {

        show(.success, function: function, file: file, line: line, message: message)
    }
}
