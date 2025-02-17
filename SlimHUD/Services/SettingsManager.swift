//
//  SettingsManager.swift
//  SlimHUD
//
//  Created by Alex Perathoner on 24/12/22.
//

import Cocoa

class SettingsManager {

    // MARK: - Keys

    private static let VolumeBackgroundColorKey = "volumeBackgroundColor"
    private static let BrightnessBackgroundColorKey = "brightnessBackgroundColor"
    private static let KeyboardBackgroundColorKey = "keyboardBackgroundColor"
    private static let VolumeEnabledColorKey = "volumeEnabledColor"
    private static let VolumeDisabledColorKey = "volumeDisabledColor"
    private static let BrightnessColorKey = "brightnessColor"
    private static let KeyboardColorKey = "keyboardColor"
    private static let VolumeIconColorKey = "volumeIconColor"
    private static let BrightnessIconColorKey = "brightnessIconColor"
    private static let KeyboardIconColorKey = "keyboardIconColor"
    private static let ShouldShowIconsKey = "shouldShowIcons"
    private static let ShadowColorKey = "shadowColor"
    private static let ShadowTypeKey = "shadowType"
    private static let ShadowInsetKey = "shadowInset"
    private static let ShadowRadiusKey = "shadowRadius"
    private static let ShouldContinuouslyCheckKey = "shouldContinuouslyCheck"
    private static let AnimationStyleKey = "animationStyle"
    private static let BarHeightKey = "barHeight"
    private static let BarThicknessKey = "barThickness"
    private static let PositionKey = "position"
    private static let EnabledBarsKey = "enabledBars"
    private static let MarginKey = "marginValue"
    private static let FlatBarKey = "flatBar"
    private static let ShouldHideMenuBarIconKey = "shouldHideMenuBarIcon"
    
    //Additional from project fork
    private static let BackgroundEnabled = "enabledBG"

    // MARK: - Bars colors
    var volumeBackgroundColor: NSColor {
        didSet {
            UserDefaultsManager.setItem(volumeBackgroundColor, for: SettingsManager.VolumeBackgroundColorKey)
        }
    }
    var brightnessBackgroundColor: NSColor {
        didSet {
            UserDefaultsManager.setItem(brightnessBackgroundColor, for: SettingsManager.BrightnessBackgroundColorKey)
        }
    }
    var keyboardBackgroundColor: NSColor {
        didSet {
            UserDefaultsManager.setItem(keyboardBackgroundColor, for: SettingsManager.KeyboardBackgroundColorKey)
        }
    }
    var volumeEnabledColor: NSColor {
        didSet {
            UserDefaultsManager.setItem(volumeEnabledColor, for: SettingsManager.VolumeEnabledColorKey)
        }
    }
    var volumeDisabledColor: NSColor {
        didSet {
            UserDefaultsManager.setItem(volumeDisabledColor, for: SettingsManager.VolumeDisabledColorKey)
        }
    }
    var brightnessColor: NSColor {
        didSet {
            UserDefaultsManager.setItem(brightnessColor, for: SettingsManager.BrightnessColorKey)
        }
    }
    var keyboardColor: NSColor {
        didSet {
            UserDefaultsManager.setItem(keyboardColor, for: SettingsManager.KeyboardColorKey)
        }
    }
    // MARK: - Icons colors
    var volumeIconColor: NSColor {
        didSet {
            UserDefaultsManager.setItem(volumeIconColor, for: SettingsManager.VolumeIconColorKey)
        }
    }
    var brightnessIconColor: NSColor {
        didSet {
            UserDefaultsManager.setItem(brightnessIconColor, for: SettingsManager.BrightnessIconColorKey)
        }
    }
    var keyboardIconColor: NSColor {
        didSet {
            UserDefaultsManager.setItem(keyboardIconColor, for: SettingsManager.KeyboardIconColorKey)
        }
    }

    // MARK: - Effects colors
    var shadowColor: NSColor {
        didSet {
            UserDefaultsManager.setItem(shadowColor, for: SettingsManager.ShadowColorKey)
        }
    }
    var shadowType: ShadowType {
        didSet {
            UserDefaults.standard.set(shadowType.rawValue, forKey: SettingsManager.ShadowTypeKey)
        }
    }
    var shadowInset: Int {
        didSet {
            UserDefaults.standard.set(shadowInset, forKey: SettingsManager.ShadowInsetKey)
        }
    }
    var shadowRadius: Int {
        didSet {
            UserDefaults.standard.set(shadowRadius, forKey: SettingsManager.ShadowRadiusKey)
        }
    }

    var shouldShowIcons: Bool {
        didSet {
            UserDefaults.standard.set(shouldShowIcons, forKey: SettingsManager.ShouldShowIconsKey)
        }
    }
    var shouldContinuouslyCheck: Bool {
        didSet {
            UserDefaults.standard.set(shouldContinuouslyCheck, forKey: SettingsManager.ShouldContinuouslyCheckKey)
        }
    }
    var animationStyle: AnimationStyle {
        didSet {
            UserDefaults.standard.set(animationStyle.rawValue, forKey: SettingsManager.AnimationStyleKey)
        }
    }

    var barHeight: Int {
        didSet {
            UserDefaults.standard.set(barHeight, forKey: SettingsManager.BarHeightKey)
        }
    }
    var barThickness: Int {
        didSet {
            UserDefaults.standard.set(barThickness, forKey: SettingsManager.BarThicknessKey)
        }
    }
    var position: Position = Position.left {
        didSet {
            UserDefaults.standard.set(position.rawValue, forKey: SettingsManager.PositionKey)
        }
    }

    var flatBar: Bool {
        didSet {
            UserDefaults.standard.set(flatBar, forKey: SettingsManager.FlatBarKey)
        }
    }

    // MARK: - General
    var enabledBars: EnabledBars {
        didSet {
            let enabledBarsRaw = [enabledBars.volumeBar,
                                  enabledBars.brightnessBar,
                                  enabledBars.keyboardBar]
            UserDefaults.standard.set(enabledBarsRaw, forKey: SettingsManager.EnabledBarsKey)
        }
    }
    
    var enabledBackground : Bool {
        didSet {
            UserDefaults.standard.set(enabledBackground, forKey: SettingsManager.BackgroundEnabled)
        }
    }

    var marginValue: Int {
        didSet {
            UserDefaults.standard.set(marginValue, forKey: SettingsManager.MarginKey)
        }
    }

    var shouldHideMenuBarIcon: Bool {
        didSet {
            UserDefaults.standard.set(shouldHideMenuBarIcon, forKey: SettingsManager.ShouldHideMenuBarIconKey)
        }
    }

    // MARK: - Class methods

    static private let singletonSettingsController = SettingsManager()
    public static func getInstance() -> SettingsManager {
        return singletonSettingsController
    }

    private init() {
        volumeBackgroundColor = UserDefaultsManager.getItem(for: SettingsManager.VolumeBackgroundColorKey, defaultValue: DefaultColors.DarkGray)
        brightnessBackgroundColor = UserDefaultsManager.getItem(for: SettingsManager.BrightnessBackgroundColorKey, defaultValue: DefaultColors.DarkGray)
        keyboardBackgroundColor = UserDefaultsManager.getItem(for: SettingsManager.KeyboardBackgroundColorKey, defaultValue: DefaultColors.DarkGray)
        volumeEnabledColor = UserDefaultsManager.getItem(for: SettingsManager.VolumeEnabledColorKey, defaultValue: DefaultColors.Blue)
        volumeDisabledColor = UserDefaultsManager.getItem(for: SettingsManager.VolumeDisabledColorKey, defaultValue: DefaultColors.Gray)
        brightnessColor = UserDefaultsManager.getItem(for: SettingsManager.BrightnessColorKey, defaultValue: DefaultColors.Yellow)
        keyboardColor = UserDefaultsManager.getItem(for: SettingsManager.KeyboardColorKey, defaultValue: DefaultColors.Azure)

        volumeIconColor = UserDefaultsManager.getItem(for: SettingsManager.VolumeIconColorKey, defaultValue: .white)
        brightnessIconColor = UserDefaultsManager.getItem(for: SettingsManager.BrightnessIconColorKey, defaultValue: .white)
        keyboardIconColor = UserDefaultsManager.getItem(for: SettingsManager.KeyboardIconColorKey, defaultValue: .white)

        shadowColor = UserDefaultsManager.getItem(for: SettingsManager.ShadowColorKey, defaultValue: NSColor.init(white: 0, alpha: 0.1))
        let rawShadowType = CommandLine.arguments.contains(SettingsManager.ShadowTypeKey) ?
            CommandLine.arguments[CommandLine.arguments.firstIndex(of: SettingsManager.ShadowTypeKey)! + 1] :
            UserDefaultsManager.getString(for: SettingsManager.ShadowTypeKey, defaultValue: ShadowType.nsshadow.rawValue)
        shadowType = ShadowType(rawValue: rawShadowType) ?? .nsshadow
        shadowInset = UserDefaultsManager.getInt(for: SettingsManager.ShadowInsetKey, defaultValue: 5)
        shadowRadius = UserDefaultsManager.getInt(for: SettingsManager.ShadowRadiusKey, defaultValue: 10)

        shouldShowIcons = UserDefaultsManager.getBool(for: SettingsManager.ShouldShowIconsKey, defaultValue: true)
        barHeight = CommandLine.arguments.contains("hudSize") ?
            Int(Float(CommandLine.arguments[CommandLine.arguments.firstIndex(of: "hudSize")! + 2])!) :
            UserDefaultsManager.getInt(for: SettingsManager.BarHeightKey, defaultValue: 218)
        barThickness = CommandLine.arguments.contains("hudSize") ?
            Int(Float(CommandLine.arguments[CommandLine.arguments.firstIndex(of: "hudSize")! + 1])!) :
            UserDefaultsManager.getInt(for: SettingsManager.BarThicknessKey, defaultValue: 7)
        let rawPosition = CommandLine.arguments.contains("hudEdge") ?
            CommandLine.arguments[CommandLine.arguments.firstIndex(of: "hudEdge")! + 1] :
            UserDefaultsManager.getString(for: SettingsManager.PositionKey, defaultValue: "left")
        position = Position(rawValue: rawPosition) ?? .left
        shouldContinuouslyCheck = CommandLine.arguments.contains(SettingsManager.ShouldContinuouslyCheckKey) ?
            true : UserDefaultsManager.getBool(for: SettingsManager.ShouldContinuouslyCheckKey, defaultValue: false)
        shouldHideMenuBarIcon = UserDefaultsManager.getBool(for: SettingsManager.ShouldHideMenuBarIconKey, defaultValue: false)
        animationStyle = AnimationStyle(from: UserDefaultsManager.getString(for: SettingsManager.AnimationStyleKey, defaultValue: ""))
        let enabledBarsRaw = UserDefaultsManager.getArr(for: SettingsManager.EnabledBarsKey, defaultValue: [true, true, true])
        let (volumeBarEnabled, brightnessBarEnabled, keyboardBarEnabled) =
            (enabledBarsRaw[EnabledBars.VolumeBarIndex],
             enabledBarsRaw[EnabledBars.BrightnessBarIndex],
             enabledBarsRaw[EnabledBars.KeyboardBarIndex])
        enabledBars = EnabledBars(volumeBar: volumeBarEnabled, brightnessBar: brightnessBarEnabled, keyboardBar: keyboardBarEnabled)
        marginValue = UserDefaultsManager.getInt(for: SettingsManager.MarginKey, defaultValue: 10)
        flatBar = UserDefaultsManager.getBool(for: SettingsManager.FlatBarKey, defaultValue: false)
        
        enabledBackground = UserDefaultsManager.getBool(for: SettingsManager.BackgroundEnabled, defaultValue: false)
    }

    func resetDefaultBarsColors() {
        volumeBackgroundColor = DefaultColors.DarkGray
        brightnessBackgroundColor = DefaultColors.DarkGray
        keyboardBackgroundColor = DefaultColors.DarkGray
        volumeEnabledColor = DefaultColors.Blue
        volumeDisabledColor = DefaultColors.Gray
        brightnessColor = DefaultColors.Yellow
        keyboardColor = DefaultColors.Azure
    }

    func resetDefaultIconsColors() {
        volumeIconColor = .white
        brightnessIconColor = .white
        keyboardIconColor = .white
    }
}
