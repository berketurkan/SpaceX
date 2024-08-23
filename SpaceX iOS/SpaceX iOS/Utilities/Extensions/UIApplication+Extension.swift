//
//  UIApplication+Extension.swift
//  SpaceX iOS
//
//  Created by Vestel on 23.08.2024.
//

import UIKit

extension UIApplication {
    var rootViewController: UIViewController? {
        guard let scene = connectedScenes.first as? UIWindowScene else { return nil }
        return scene.windows.first?.rootViewController
    }
}

