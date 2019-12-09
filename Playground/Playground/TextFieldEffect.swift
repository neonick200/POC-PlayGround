//
//  TextFieldsEffects.swift
//  TextFieldEffects
//
//  Created by Raúl Riera on 24/01/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

public protocol Validatable {
  func setValid()
  func setInvalid()
}

/**
 A TextFieldEffects object is a control that displays editable text and contains the boilerplates to setup unique animations for text entrey and display. You typically use this class the same way you use UITextField.
 */
open class TextFieldEffects: UITextField {
  
  /**
   The type of animatino a TextFieldEffect can perform.
   
   - TextEntry: animation that takes effect when the textfield has focus.
   - TextDisplay: animation that takes effect when the textfield loses focus.
   */
  public enum AnimationType: Int {
    case textEntry
    case textDisplay
  }
  
  public var isValid = true
  
  /**
   Closure executed when an animation has been completed.
   */
  public typealias AnimationCompletionHandler = (_ type: AnimationType) -> Void
  
  /**
   UILabel that holds all the placeholder information
   */
  
  /**
   Creates all the animations that are used to leave the textfield in the "entering text" state.
   */
  open func animateViewsForTextEntry() {
    fatalError("\(#function) must be overridden")
  }
  
  /**
   Creates all the animations that are used to leave the textfield in the "display input text" state.
   */
  open func animateViewsForTextDisplay() {
    fatalError("\(#function) must be overridden")
  }
  
  /**
   The animation completion handler is the best place to be notified when the text field animation has ended.
   */
  open var animationCompletionHandler: AnimationCompletionHandler?
  
  /**
   Draws the receiver’s image within the passed-in rectangle.
   
   - parameter rect:  The portion of the view’s bounds that needs to be updated.
   */
  open func drawViewsFor(rect: CGRect) {
    fatalError("\(#function) must be overridden")
  }
    
  // MARK: - Overrides
  
  
  override open var text: String? {
    didSet {
      if let text = text, !text.isEmpty {
        animateViewsForTextEntry()
      } else {
        animateViewsForTextDisplay()
      }
    }
  }
  
  // MARK: - UITextField Observing
  
  override open func willMove(toSuperview newSuperview: UIView!) {
    if newSuperview != nil {
      NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidEndEditing), name: UITextField.textDidEndEditingNotification, object: self)
      
      NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidBeginEditing), name: UITextField.textDidBeginEditingNotification, object: self)
    } else {
      NotificationCenter.default.removeObserver(self)
    }
  }
  
  /**
   The textfield has started an editing session.
   */
  @objc open func textFieldDidBeginEditing() {
    animateViewsForTextEntry()
  }
  
  /**
   The textfield has ended an editing session.
   */
  @objc open func textFieldDidEndEditing() {
    animateViewsForTextDisplay()
  }
  
  // MARK: - Interface Builder
  
  override open func prepareForInterfaceBuilder() {
    drawViewsFor(rect: frame)
  }
}
