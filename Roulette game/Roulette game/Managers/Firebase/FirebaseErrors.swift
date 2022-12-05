//
//  FirebaseErrors.swift
//  Roulette game
//
//  Created by Максим Михальчук on 03.12.2022.
//

import Foundation

enum RegistrationError: CaseIterable {
    
    case defaultError
    
    case emailAlreadyInUse
    case weakPassword
    
    var errorCode: Int {
        switch self {
            
        case .defaultError: return 1
        case .emailAlreadyInUse: return 17007
        case .weakPassword: return 17026
        }
    }
    
    var description: String {
        switch self {
        case .defaultError: return
            "Something went wrong. try later"
        case .emailAlreadyInUse: return
            "User with this email address is already registered"
        case .weakPassword: return
            "The entered password is too weak"
        }
    }
}

enum AuthErrors: CaseIterable, Error {
    
    case userRecordNotFound
    case defaultError
    
    /** Indicates the email is invalid.
     */
    case invalidEmail

    /** Indicates the user attempted sign in with a wrong password.
     */
    case wrongPassword

    /** Indicates the user account was not found.
     */
    case userNotFound

    /** Indicates a network error occurred (such as a timeout, interrupted connection, or
        unreachable host). These types of errors are often recoverable with a retry. The
        `NSUnderlyingError` field in the `NSError.userInfo` dictionary will contain the error
        encountered.
     */
    case networkError

    /** Indicates that a non-null user was expected as an argmument to the operation but a null
        user was provided.
     */
    case nullUser

    /** Indicates an error occurred while attempting to access the keychain.
     */
    case keychainError

    /** Indicates an internal error occurred.
     */
    case internalError
    
    var errorCode: Int {
        switch self {
            
        case .defaultError: return 0
        case .userRecordNotFound: return 1
        
        case .invalidEmail: return 17008
        case .wrongPassword: return 17009
        case .userNotFound: return 17011
        case .networkError: return 17020
        case .nullUser: return 17067
        case .keychainError: return 17995
        case .internalError: return 17999
        }
    }
    
    var description: String {
        switch self {
        
        case .userRecordNotFound:  return
            "Account data not found"
        case .defaultError: return
            "There was an error, please try again later"
        case .invalidEmail: return
            "Email is invalid"
        case .wrongPassword: return
            "Invalid password. Check if the entered data is correct"
        case .userNotFound: return
            "No user found with this email. Check if the entered data is correct"
        case .networkError: return
            "Internet connection error. Please try again"
        case .nullUser: return
            "User is not found"
        case .keychainError: return
            "Keychain access failure"
        case .internalError: return
            "An error has occurred. try later"
        }
    }
}

enum GoogleErrors: CaseIterable {
    
    /// Indicates an unknown error has occurred.
    case unknown

    /// Indicates a problem reading or writing to the application keychain.
    case keychain

    /// Indicates there are no valid auth tokens in the keychain. This error code will be returned by
    /// `restorePreviousSignIn` if the user has not signed in before or if they have since signed out.
    case hasNoAuthInKeychain

    /// Indicates the user canceled the sign in request.
    case canceled

    /// Indicates an Enterprise Mobility Management related error has occurred.
    case EMM

    /// Indicates there is no `currentUser`.
    case noCurrentUser

    /// Indicates the requested scopes have already been granted to the `currentUser`.
    case scopesAlreadyGranted
    
    var errorCode: Int {
        switch self {

        case .unknown: return -1
        case .keychain: return -2
        case .hasNoAuthInKeychain: return -4
        case .canceled: return -5
        case .EMM: return -6
        case .noCurrentUser: return -7
        case .scopesAlreadyGranted: return -8
        }
    }
    
    var description: String {
        switch self {
            
        case .unknown: return ""
        case .keychain: return ""
        case .hasNoAuthInKeychain: return ""
        case .canceled: return ""
        case .EMM: return ""
        case .noCurrentUser: return ""
        case .scopesAlreadyGranted: return ""
        }
    }
}
