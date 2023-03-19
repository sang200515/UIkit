//
//  VideoPermission.swift
//  fptshop
//
//  Created by KhanhNguyen on 10/26/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import AVFoundation

final class VideoPermission {
    // MARK: - Authorization

    /// Checks authorization status of the capture device.
    func checkPersmission(completion: @escaping (Error?) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            completion(nil)
        case .notDetermined:
            askForPermissions(completion)
        default:
            completion(ScannerQRCustomError.notAuthorizedToUseCamera)
        }
    }

    /// Asks for permission to use video.
    private func askForPermissions(_ completion: @escaping (Error?) -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                guard granted else {
                    completion(ScannerQRCustomError.notAuthorizedToUseCamera)
                    return
                }
                completion(nil)
            }
        }
    }
}

