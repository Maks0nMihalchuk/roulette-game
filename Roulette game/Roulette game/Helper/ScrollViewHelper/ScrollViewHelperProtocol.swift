//
//  ScrollViewHelperProtocol.swift
//  Roulette game
//
//  Created by Максим Михальчук on 02.12.2022.
//

import UIKit

protocol ScrollViewHelperProtocol {
    
    var delegate: ScrollViewHelperDelegate? { get set }

    func keyboardWillShow(_ notification: NSNotification)
    func keyboardWillHide(_ notification: NSNotification)
    func keyboardWillChangeFrame(_ notification: NSNotification)
}
