//
//  UIViewController+alert.swift
//  PhonePuzzle
//
//  Created by moisey on 18.02.2018.
//  Copyright © 2017 moisey. All rights reserved.
//

import UIKit

extension UIViewController {
 
    enum ActionType {
        case NewGame, Correct
    }
    
    private func addActions(alertVC: UIAlertController, actions: [ActionType], actionHandler: @escaping (ActionType) -> Void)
    {
        for action in actions
        {
            switch action
            {
            case .NewGame:
                alertVC.addAction(UIAlertAction(title: String.localized(key: .alert_new_game),
                                                style: .default,
                                                handler: { _ in
                        actionHandler(.NewGame)
                }))
                
            case .Correct:
                alertVC.addAction(UIAlertAction(title: String.localized(key: .alert_correct),
                                                style: .default,
                                                handler: { _ in
                        actionHandler(.Correct)
                }))
            
            }
        }
    }
    
    func alert(title: String, text: String?, actions: [ActionType], actionHandler: @escaping (ActionType) -> Void) {
        
        let alertVC = UIAlertController(title: title, message: text, preferredStyle: .alert)
        self.addActions(alertVC: alertVC, actions: actions) { (actionType) in
            actionHandler(actionType)
        }
        self.present(alertVC, animated: true, completion: nil)
    }
}
