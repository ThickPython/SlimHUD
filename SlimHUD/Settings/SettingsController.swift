//
//  SettingsController.swift
//  SlimHUD
//
//  Created by Alex Perathoner on 03/03/2020.
//  Copyright © 2020 Alex Perathoner. All rights reserved.
//

import Cocoa


enum Position: String {
	case left = "left"
	case right = "right"
	case bottom = "bottom"
	case top = "top"
}


class SettingsController {
	// MARK: - Default colors
	static let darkGray = NSColor(red: 0.34, green: 0.4, blue: 0.46, alpha: 0.2)
	static let gray = NSColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.9)
	static let blue = NSColor(red: 0.19, green: 0.5, blue: 0.96, alpha: 0.9)
	static let yellow = NSColor(red: 0.77, green: 0.7, blue: 0.3, alpha: 1)
	static let azure = NSColor(red: 0.62, green: 0.8, blue: 0.91, alpha: 0.9)
	
	 // MARK: - Bars colors
	var backgroundColor: NSColor! {
		didSet {
			setItem(backgroundColor, for: "backgroundColor")
		}
	}
	var volumeEnabledColor: NSColor! {
		didSet {
			setItem(volumeEnabledColor, for: "volumeEnabledColor")
		}
	}
	var volumeDisabledColor: NSColor! {
		didSet {
			setItem(volumeDisabledColor, for: "volumeDisabledColor")
		}
	}
	var brightnessColor: NSColor! {
		didSet {
			setItem(brightnessColor, for: "brightnessColor")
		}
	}
	var keyboardColor: NSColor! {
		didSet {
			setItem(keyboardColor, for: "keyboardColor")
		}
	}
	// MARK: - Icons colors
	var volumeIconColor: NSColor! {
		didSet {
			setItem(keyboardColor, for: "volumeIconColor")
		}
	}
	var brightnessIconColor: NSColor! {
		didSet {
			setItem(keyboardColor, for: "brightnessIconColor")
		}
	}
	var keyboardIconColor: NSColor! {
		didSet {
			setItem(keyboardColor, for: "keyboardIconColor")
		}
	}
	
	// MARK: - Effects colors
	var shouldShowShadows: Bool! = true {
		didSet {
			setItem(shouldShowShadows, for: "shouldShowShadows")
		}
	}
	var shouldShowIcons: Bool! = true {
		didSet {
			setItem(shouldShowIcons, for: "shouldShowIcons")
		}
	}
	var shouldContinuouslyCheck: Bool! = true {
		didSet {
			setItem(shouldContinuouslyCheck, for: "shouldContinuouslyCheck")
		}
	}
	var shouldUseAnimation: Bool! = true {
		didSet {
			setItem(shouldUseAnimation, for: "shouldUseAnimation")
		}
	}
	
	var barHeight: Int = 218 {
		didSet {
			setItem(barHeight, for: "barHeight")
		}
	}
	var barThickness: Int = 7 {
		didSet {
			setItem(barThickness, for: "barThickness")
		}
	}
	var position: Position = Position.left {
		didSet {
			setItem(position.rawValue, for: "position")
		}
	}
	
	// MARK: - General
	var enabledBars: [Bool] = [true, true, true] {
		didSet {
			setItem(enabledBars, for: "enabledBars")
		}
	}
	
	var marginValue: Int {
		set {
			UserDefaults.standard.set(newValue, forKey: "marginValue")
		}
		get {
			UserDefaults.standard.integer(forKey: "marginValue")
		}
	}
	
	// MARK: - Class methods
	init() {
		backgroundColor = getItem(for: "backgroundColor", defaultValue: SettingsController.darkGray)
		volumeEnabledColor = getItem(for: "volumeEnabledColor", defaultValue: SettingsController.blue)
		volumeDisabledColor = getItem(for: "volumeDisabledColor", defaultValue: SettingsController.gray)
		brightnessColor = getItem(for: "brightnessColor", defaultValue: SettingsController.yellow)
		keyboardColor = getItem(for: "keyboardColor", defaultValue: SettingsController.azure)
		shouldShowShadows = getItem(for: "shouldShowShadows", defaultValue: true)
		shouldShowIcons = getItem(for: "shouldShowIcons", defaultValue: true)
		barHeight = getItem(for: "barHeight", defaultValue: 218)
		barThickness = getItem(for: "barThickness", defaultValue: 7)
		position = Position(rawValue: getItem(for: "position", defaultValue: "left"))!
		shouldContinuouslyCheck = getItem(for: "shouldContinuouslyCheck", defaultValue: true)
		shouldUseAnimation = getItem(for: "shouldUseAnimation", defaultValue: true)
		enabledBars = getItem(for: "enabledBars", defaultValue: [true, true, true])
	}
	
	func resetDefaultColors() {
		backgroundColor = SettingsController.darkGray
		volumeEnabledColor = SettingsController.blue
		volumeDisabledColor = SettingsController.gray
		brightnessColor = SettingsController.yellow
		keyboardColor = SettingsController.azure
	}
	
	func getItem<T>(for key: String, defaultValue: T) -> T {
        guard
            let data = UserDefaults.standard.object(forKey: key) as? Data,
			let item = NSKeyedUnarchiver.unarchiveObject(with: data) as? T else {
                return defaultValue
        }
		return item
	}
	
	func setItem<T>(_ item: T, for key: String) {
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: item), forKey: key)
	}
	
    private func saveAllItems() {
		setItem(backgroundColor, for: "backgroundColor")
		setItem(volumeEnabledColor, for: "volumeEnabledColor")
		setItem(volumeDisabledColor, for: "volumeDisabledColor")
		setItem(brightnessColor, for: "brightnessColor")
		setItem(keyboardColor, for: "keyboardColor")
		setItem(shouldShowShadows, for: "shouldShowShadows")
		setItem(shouldShowIcons, for: "shouldShowIcons")
		setItem(barHeight, for: "barHeight")
		setItem(barThickness, for: "barThickness")
		setItem(position, for: "position")
    }
	
	
	deinit {
		saveAllItems()
	}
	
}
