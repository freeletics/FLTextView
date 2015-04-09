//
//  ViewController.swift
//  FLTextView Example
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

class ViewController: UIViewController {
    
    @IBOutlet var textView: FLTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let placeholder = NSMutableAttributedString(string: "Lorem ipsum")
        placeholder.addAttribute(NSForegroundColorAttributeName, value: UIColor(white: 0.7, alpha: 1.0), range: NSMakeRange(0, 11))
        placeholder.addAttribute(NSStrikethroughStyleAttributeName, value: NSUnderlineStyle.StyleDouble.rawValue, range: NSMakeRange(0, 5))
        placeholder.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: NSMakeRange(6, 5))
        
        textView.attributedPlaceholder = placeholder
    }
    
}
