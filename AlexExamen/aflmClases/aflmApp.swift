//
//  aflmApp.swift
//  AlexExamen
//
//  Created by mac13 on 04/03/21.
//  Copyright © 2021 UTT. All rights reserved.
//

import UIKit

class aflmApp: NSObject {
    static let shared = aflmApp()
    let defaults = UserDefaults.standard
    var partidas = [aflmPartida]()
}
