//
//  RondedTextField.swift
//  SCB-FastEasy
//
//  Created by Willian Policiano on 12/01/17.
//  Copyright © 2017 SCB. All rights reserved.
//

open class RoundedTextField: TextFieldEffects {
  
  @IBInspectable dynamic public var borderInactiveColor: UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
  @IBInspectable dynamic public var borderActiveColor: UIColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
  @IBInspectable dynamic public var borderErrorColor: UIColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
  
  public var showBorder =  true
  public var insetDx: CGFloat = 8
  public var enableMenu: Bool = true //menu for copy, cut, paste, etc.
  
  private var clearImageButton: UIImage?
  private var clearImageTintColor: UIColor?
  private var clearImageOffset: CGPoint?
  private var tintedClearImage: UIImage?
  
  override open func drawViewsFor(rect: CGRect) {
    if showBorder {
      layer.borderWidth = 1
      layer.cornerRadius = 4.0
      setBorderColorState()
    } else {
      borderStyle = .none
    }
    
    layer.masksToBounds = true
    
    if #available(iOS 11.0, *) {
      smartQuotesType = .no
    }
  }
  
  override open func animateViewsForTextEntry() {
    setBorderColorState()
  }

  override open func animateViewsForTextDisplay() {
    setBorderColorState()
  }

  override open func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: insetDx, dy: 0)
  }
  
  override open func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: insetDx, dy: 0)
  }
  
  override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    if !enableMenu {
      UIMenuController.shared.isMenuVisible = false
      UIMenuController.shared.update()
      return false
    }
    return super.canPerformAction(action, withSender: sender)
  }
  
  private func setBorderColorState() {
    if self.isFirstResponder {
      layer.borderColor = borderActiveColor.cgColor
    } else {
      if isValid {
        layer.borderColor = borderInactiveColor.cgColor
      } else {
        layer.borderColor = borderErrorColor.cgColor
      }
    }
  }
  
  public func setClearButtonImage(image: UIImage, tintColor: UIColor? = nil, offset: CGPoint? = nil) {
    self.clearImageButton = image
    self.clearImageTintColor = tintColor
    self.clearImageOffset = offset
  }
  
  override open func layoutSubviews() {
    super.layoutSubviews()
    tintClearImage()
  }
}

extension RoundedTextField {
  private func tintClearImage() {
    for view in subviews as [UIView] {
      if view is UIButton, let button = view as? UIButton {
        if let uiImage = clearImageButton {
          if tintedClearImage == nil {
            if clearImageTintColor != nil { // Tint image with color
            } else {
              tintedClearImage = uiImage // User original image
            }
          }
          button.setImage(tintedClearImage, for: .normal)
          button.setImage(tintedClearImage, for: .highlighted)
          if let offset = clearImageOffset {
            button.frame = button.frame.offsetBy(dx: offset.x, dy: offset.y)
          }
        }
      }
    }
  }
  public func setIcon(_ image: UIImage, tintColor: UIColor?) {
    let iconImageView = UIImageView(frame: CGRect(x: 9, y: 9, width: 16, height: 16))
    iconImageView.image = image
    if let tintColor = tintColor {
      iconImageView.tintColor = tintColor
    }
    addSubview(iconImageView)
    let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: self.frame.size.height))
    leftView = paddingView
    leftViewMode = .always
  }
}

extension RoundedTextField: Validatable {
  
  public func setValid() {
    isValid = true
    layer.borderColor = borderInactiveColor.cgColor
    layer.borderWidth = 1
    layer.cornerRadius = 4.0
  }
  
  public func setInvalid() {
    isValid = false
    layer.borderColor = borderErrorColor.cgColor
    layer.borderWidth = 1
    layer.cornerRadius = 4.0
  }
  
  public func setActive() {
    isValid = true
    layer.borderColor = borderActiveColor.cgColor
    layer.borderWidth = 1
    layer.cornerRadius = 4.0
  }
}
