//
//  BarView.swift
//  SlimHUD
//
//  Created by Alex Perathoner on 24/12/22.
//

import Cocoa

class BarView: NSView {

    static let BarViewNibFileName = "BarView"

    @IBOutlet weak var bar: ProgressBar!
    @IBOutlet private var icon: NSImageView!

    private var shadowView: NSView!
    private var bgBox : NSBox!

    override func awakeFromNib() {
        if let icon = icon { // not set in
            icon.wantsLayer = true
            icon.layer?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        }
    }

    public func hideIcon(isHidden: Bool) {
        icon.isHidden = isHidden
    }

    @available(OSX 10.14, *)
    public func setIconTint(_ color: NSColor) {
        icon.contentTintColor = color
    }

    private func hasIconChanged(newIcon: NSImage) -> Bool {
        return icon.image != newIcon
    }

    public func setIconImage(icon: NSImage, force: Bool = false) {
        var color: NSColor?
        if #available(macOS 10.14, *) {
            color = self.icon.contentTintColor
        }
        if force || hasIconChanged(newIcon: icon) {
            CATransaction.begin()
            CATransaction.setAnimationDuration(0.1)

            let transition = CATransition()
            transition.type = CATransitionType.fade

            let timingFunction = CAMediaTimingFunction(name: .easeOut)
            CATransaction.setAnimationTimingFunction(timingFunction)

            self.icon.layer?.add(transition, forKey: kCATransition)
            self.icon.image = icon
            if #available(macOS 10.14, *) {
                self.icon.contentTintColor = color
            }

            CATransaction.commit()
        }
    }

    public func setIconRotation(isHorizontal: Bool) {
        if isHorizontal {
            while icon.boundsRotation.truncatingRemainder(dividingBy: 360) != 90 {
                icon.rotate(byDegrees: 90)
            }
        } else {
            while icon.boundsRotation.truncatingRemainder(dividingBy: 360) != 0 {
                icon.rotate(byDegrees: 90)
            }
        }
    }

    public func setupShadowAsView(radius: Int, color: NSColor = .black, inset: Int = 5) {
        disableShadowView()

        let shadowFrame = calculateShadowFrame(shadowInset: inset)
        shadowView = NSView(frame: shadowFrame)
        shadowView.wantsLayer = true
        shadowView.layer?.cornerRadius = (min(self.frame.height, self.frame.width) - CGFloat(inset * 2)) / 2.2 // rounded rectangle
        shadowView.layer?.backgroundColor = color.cgColor
        if radius > 0 {
            shadowView.layer?.mask = createMaskLayer(shadowFrame: shadowFrame, shadowRadius: radius)
        }
        self.addSubview(shadowView, positioned: .below, relativeTo: icon.isHidden ? bar : self)
    }
    
    public func disableShadowView() {
        if shadowView != nil {
            shadowView.removeFromSuperview()
            shadowView = nil
        }
    }
        
    //background view
    public func setupBackgroundAsView(roundCornerRadius: Int, color: NSColor = .lightGray) {
        destroyBGBox()
        bgBox = NSBox(frame: NSRect(origin: .zero, size: CGSize(width: self.bounds.width, height: self.bounds.height)))
        bgBox.boxType = .custom
        
        bgBox.borderWidth = 0
        bgBox.wantsLayer = true
        bgBox.cornerRadius = self.bounds.width < 20 ? self.bounds.width : 20
        
        bgBox.fillColor = .systemGray
        bgBox.isTransparent = false
        bgBox.title = ""
        self.addSubview(bgBox, positioned: .below, relativeTo: icon.isHidden ? bar : self)
    }
    
    //destroys the existing box when reenabling so you don't have multiple overlapping views
    func destroyBGBox() {
        if(bgBox != nil) {
            bgBox.removeFromSuperview()
            bgBox = nil
        }
        
    }
    
    ///Sets the background as in the background for the entire barview
    public func setBackground(toEnable : Bool)  {
        bgBox.isHidden = !toEnable
    }
    
    
    private func createMaskLayer(shadowFrame: NSRect, shadowRadius: Int) -> CALayer {
        let verticalGradientLength = CGFloat(shadowRadius) / shadowFrame.height * 1.5 // only because it looks better
        let verticalGradient = CAGradientLayer()
        verticalGradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        verticalGradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        verticalGradient.colors = [NSColor.clear.withAlphaComponent(0.0).cgColor, NSColor.clear.withAlphaComponent(1.0).cgColor,
                                   NSColor.clear.withAlphaComponent(1.0).cgColor, NSColor.clear.withAlphaComponent(0.0).cgColor]
        verticalGradient.locations = [NSNumber(value: 0.0), NSNumber(value: verticalGradientLength),
                                      NSNumber(value: 1-verticalGradientLength), NSNumber(value: 1.0)]
        verticalGradient.frame = shadowView.bounds

        let horizontalGradientLength = CGFloat(shadowRadius) / shadowFrame.width
        let horizontalGradient = CAGradientLayer()
        horizontalGradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        horizontalGradient.endPoint = CGPoint(x: 1.0, y: 0.0)
        horizontalGradient.colors = [NSColor.clear.withAlphaComponent(0.0).cgColor, NSColor.clear.withAlphaComponent(1.0).cgColor,
                                     NSColor.clear.withAlphaComponent(1.0).cgColor, NSColor.clear.withAlphaComponent(0.0).cgColor]
        horizontalGradient.locations = [NSNumber(value: 0.0), NSNumber(value: horizontalGradientLength),
                                        NSNumber(value: 1-horizontalGradientLength), NSNumber(value: 1.0)]
        horizontalGradient.frame = shadowView.bounds
        verticalGradient.mask = horizontalGradient

        return verticalGradient.flatten()
    }

    private func calculateShadowFrame(shadowInset: Int) -> NSRect {
        if icon.isHidden {
            return bar.frame.insetBy(dx: CGFloat(-20+(shadowInset)), dy: CGFloat(-20+shadowInset))
        } else {
            let size = self.frame.insetBy(dx: CGFloat(shadowInset), dy: CGFloat(shadowInset)).size
            let origin = NSPoint(x: CGFloat(shadowInset), y: CGFloat(shadowInset))
            return NSRect(origin: origin, size: size)
        }
    }
}
