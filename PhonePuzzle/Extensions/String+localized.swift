//
//  String+localized.swift
//  PhonePuzzle
//
//  Created by moisey on 19.02.2018.
//  Copyright © 2017 moisey. All rights reserved.
//

import Foundation

extension String {
    
    public enum TranslationKey: Int {
        
        case alert_new_game
        case alert_correct
        
        case camera
        case library
        
        case main_app_name
        case main_message
        
        case editor_start_button
        case editor_subtitle
        
        case playfield_new_game_button
        case playfield_preview_button
        case playfield_puzzle_correct_title
        case playfield_puzzle_correct_message
        case playfield_puzzle_incorrect_title
        case playfield_puzzle_incorrect_message
    }
    
    public static func localized(key: TranslationKey, defaultValue: String = "") -> String {
        let localizedString = NSLocalizedString("\(key)", bundle: Bundle.main, value: defaultValue, comment: "\(key)")
        return localizedString
    }
}
