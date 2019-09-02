//
//  AppConstants.swift
//  CBVogoManager
//
//  Created by Abhilash Palem on 06/08/19.
//  Copyright © 2019 Abhilash Palem. All rights reserved.
//

import UIKit

//MARK: - AppConstants
struct AppConstants {
    struct display {
        static let unnamedService = "Unnamed Service"
        static let Error = "Error"
        static let success = "Success"
    }
    
    struct errMsgs {
        static let failedToConnect = "Failed to connect to peripheral with error"
        static let failedToReadData = "Issue in reading data. please try again"
    }
    
    struct successMsgs {
        static let dataWrittenSuccessFulMsg = "Data sucessfully written to characteristic"
    }
    
    struct VCTitles {
        static let serviceVC = "Service UUIDS"
        static let characteristicsVC = "Characteristic UUIDS"
        static let characteristicVC = "Play Around"
    }
}
