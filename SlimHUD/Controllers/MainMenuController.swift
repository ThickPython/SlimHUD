//
//  MainMenuController.swift
//  SlimHUD
//
//  Created by Alex Perathoner on 13/01/23.
//

import Cocoa

class MainMenuController: NSWindowController {

    var settingsWindowController: SettingsWindowController?

    var settingsManager: SettingsManager = SettingsManager.getInstance()

    @IBAction func quitCliked(_ sender: Any) {
        if isSomeWindowVisible() {
            if settingsManager.showQuitAlert {
                let alertResponse = showAlert(question: "SlimHUD will continue to show HUDs",
                                              text: "If you want to quit, click quit again",
                                              buttonsTitle: ["OK", "Quit now", "Don't show again"])
                if alertResponse == NSApplication.ModalResponse.alertSecondButtonReturn {
                    quit()
                }
                if alertResponse == NSApplication.ModalResponse.alertThirdButtonReturn {
                    settingsManager.showQuitAlert = false
                }
            }
            closeAllWindows()
            NSApplication.shared.setActivationPolicy(.accessory)
        } else {
            quit()
        }
    }
    
    override func awakeFromNib() {
        if CommandLine.arguments.contains("showSettingsAtLaunch") {
            showSettingsWindow()
        }
    }
    
    func showSettingsWindow() {
        if settingsWindowController != nil {
            settingsWindowController?.showWindow(self)
        } else {
            if let windowController = NSStoryboard(name: "Settings", bundle: nil).instantiateInitialController() as? SettingsWindowController {
                settingsWindowController = windowController
                windowController.showWindow(self)
            }
        }
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {_ in
            NSApplication.shared.setActivationPolicy(.regular)
            NSApp.activate(ignoringOtherApps: true)
        })
    }

    @IBAction func settingsClicked(_ sender: Any) {
        showSettingsWindow()
    }

    private func closeAllWindows() {
        settingsWindowController?.close()
    }

    private func quit() {
        settingsManager.saveAllItems()
        OSDUIManager.start()
        exit(0)
    }

    private func isSomeWindowVisible() -> Bool {
        return (settingsWindowController?.window?.isVisible ?? false) &&
            NSApplication.shared.activationPolicy() != .accessory
    }
}
