//
//  FLTextView.swift
//  FLTextView
//
//  Created by Danilo Bürger on 07.04.15.
//  Copyright (c) 2015 Freeletics GmbH (https://www.freeletics.com/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit

@objc(FLTextView)
public class FLTextView: UITextView {
    
    // MARK: - Private Properties
    
    private let placeholderView = UITextView(frame: CGRect.zero)
    
    // MARK: - Placeholder Properties
    
    /// This property applies to the entire placeholder string. 
    /// The default placeholder color is 70% gray.
    ///
    /// If you want to apply the color to only a portion of the placeholder,
    /// you must create a new attributed string with the desired style information 
    /// and assign it to the attributedPlaceholder property.
    @IBInspectable public var placeholderTextColor: UIColor? {
        get {
            return placeholderView.textColor
        }
        set {
            placeholderView.textColor = newValue
        }
    }
    
    /// The string that is displayed when there is no other text in the text view.
    @IBInspectable public var placeholder: String? {
        get {
            return placeholderView.text
        }
        set {
            placeholderView.text = newValue
            setNeedsLayout()
        }
    }
    
    /// This property controls when the placeholder should hide.
    /// Setting it to `true` will hide the placeholder right after the text view 
    /// becomes first responder. Setting it to `false` will hide the placeholder
    /// only when the user starts typing in the text view. 
    
    /// Default value is `false`
    @IBInspectable public var hidesPlaceholderWhenEditingBegins: Bool = false
    
    /// The styled string that is displayed when there is no other text in the text view.
    public var attributedPlaceholder: NSAttributedString? {
        get {
            return placeholderView.attributedText
        }
        set {
            placeholderView.attributedText = newValue
            setNeedsLayout()
        }
    }
    
    /// Returns true if the placeholder is currently showing.
    public var isShowingPlaceholder: Bool {
        return placeholderView.superview != nil
    }
    
    // MARK: - Observed Properties
    
    override public var text: String! {
        didSet {
            showPlaceholderViewIfNeeded()
        }
    }
    
    override public var attributedText: NSAttributedString! {
        didSet {
            showPlaceholderViewIfNeeded()
        }
    }
    
    override public var font: UIFont? {
        didSet {
            placeholderView.font = font
        }
    }
    
    override public var textAlignment: NSTextAlignment {
        didSet {
            placeholderView.textAlignment = textAlignment
        }
    }
    
    override public var textContainerInset: UIEdgeInsets {
        didSet {
            placeholderView.textContainerInset = textContainerInset
        }
    }
    
    // MARK: - Initialization
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupPlaceholderView()
    }
    
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupPlaceholderView()
    }
    
    deinit {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self)
    }
    
    // MARK: - Notification
    
    func textDidChange(notification: NSNotification) {
        showPlaceholderViewIfNeeded()
    }
    
    func textViewDidBeginEditing(notification: NSNotification) {
        if hidesPlaceholderWhenEditingBegins && isShowingPlaceholder {
            placeholderView.removeFromSuperview()
            invalidateIntrinsicContentSize()
            setContentOffset(CGPoint.zero, animated: false)
        }
    }
    
    func textViewDidEndEditing(notification: NSNotification) {
        if hidesPlaceholderWhenEditingBegins {
            if !isShowingPlaceholder && (text == nil || text.isEmpty) {
                addSubview(placeholderView)
                invalidateIntrinsicContentSize()
                setContentOffset(CGPoint.zero, animated: false)
            }
        }
    }
    
    // MARK: - UIView
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        resizePlaceholderView()
    }
    
    public override func intrinsicContentSize() -> CGSize {
        if isShowingPlaceholder {
            return placeholderSize()
        }
        return super.intrinsicContentSize()
    }
    
    // MARK: - Placeholder
    
    private func setupPlaceholderView() {
        placeholderView.opaque = false
        placeholderView.backgroundColor = UIColor.clearColor()
        placeholderView.textColor = UIColor(white: 0.7, alpha: 1.0)
        
        placeholderView.editable = false
        placeholderView.scrollEnabled = true
        placeholderView.userInteractionEnabled = false
        placeholderView.isAccessibilityElement = false
        placeholderView.selectable = false
        
        showPlaceholderViewIfNeeded()
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: #selector(UITextInputDelegate.textDidChange(_:)), name: UITextViewTextDidChangeNotification, object: self)
        notificationCenter.addObserver(self, selector: #selector(textViewDidBeginEditing(_:)), name: UITextViewTextDidBeginEditingNotification, object: self)
        notificationCenter.addObserver(self, selector: #selector(textViewDidEndEditing(_:)), name: UITextViewTextDidEndEditingNotification, object: self)
    }
    
    private func showPlaceholderViewIfNeeded() {
        if !hidesPlaceholderWhenEditingBegins {
            if text != nil && !text.isEmpty {
                if isShowingPlaceholder {
                    placeholderView.removeFromSuperview()
                    invalidateIntrinsicContentSize()
                    setContentOffset(CGPoint.zero, animated: false)
                }
            } else {
                if !isShowingPlaceholder {
                    addSubview(placeholderView)
                    invalidateIntrinsicContentSize()
                    setContentOffset(CGPoint.zero, animated: false)
                }
            }
        }
    }
    
    private func resizePlaceholderView() {
        if isShowingPlaceholder {
            let size = placeholderSize()
            let frame = CGRectMake(0.0, 0.0, size.width, size.height)
            
            if !CGRectEqualToRect(placeholderView.frame, frame) {
                placeholderView.frame = frame
                invalidateIntrinsicContentSize()
            }
            
            contentInset = UIEdgeInsetsMake(0.0, 0.0, size.height - contentSize.height, 0.0)
        } else {
            contentInset = UIEdgeInsetsZero
        }
    }
    
    private func placeholderSize() -> CGSize {
        var maxSize = self.bounds.size
        maxSize.height = CGFloat.max
        return placeholderView.sizeThatFits(maxSize)
    }

}
