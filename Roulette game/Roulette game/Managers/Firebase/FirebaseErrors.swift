//
//  FirebaseErrors.swift
//  Roulette game
//
//  Created by Максим Михальчук on 03.12.2022.
//

import Foundation

enum RegistrationError: CaseIterable, Error {
    
    case emailAlreadyInUse
    case weakPassword
    
    var errorCode: Int {
        switch self {
        case .emailAlreadyInUse: return 17007
        case .weakPassword: return 17026
        }
    }
    
    var description: String {
        switch self {
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
    
    case invalidCustomToken

    /** Indicates the service account and the API key belong to different projects.
     */
    case customTokenMismatch

    /** Indicates the IDP token or requestUri is invalid.
     */
    case invalidCredential

    /** Indicates the user's account is disabled on the server.
     */
    case userDisabled

    /** Indicates the administrator disabled sign in with the specified identity provider.
     */
    case operationNotAllowed

    /** Indicates the email is invalid.
     */
    case invalidEmail

    /** Indicates the user attempted sign in with a wrong password.
     */
    case wrongPassword

    /** Indicates that too many requests were made to a server method.
     */
    case tooManyRequests

    /** Indicates the user account was not found.
     */
    case userNotFound

    /** Indicates account linking is required.
     */
    case accountExistsWithDifferentCredential

    /** Indicates the user has attemped to change email or password more than 5 minutes after
        signing in.
     */
    case requiresRecentLogin

    /** Indicates an attempt to link a provider to which the account is already linked.
     */
    case providerAlreadyLinked

    /** Indicates an attempt to unlink a provider that is not linked.
     */
    case noSuchProvider

    /** Indicates user's saved auth credential is invalid, the user needs to sign in again.
     */
    case invalidUserToken

    /** Indicates a network error occurred (such as a timeout, interrupted connection, or
        unreachable host). These types of errors are often recoverable with a retry. The
        `NSUnderlyingError` field in the `NSError.userInfo` dictionary will contain the error
        encountered.
     */
    case networkError

    /** Indicates the saved token has expired, for example, the user may have changed account
        password on another device. The user needs to sign in again on the device that made this
        request.
     */
    case userTokenExpired

    /** Indicates an invalid API key was supplied in the request.
     */
    case invalidAPIKey

    /** Indicates that an attempt was made to reauthenticate with a user which is not the current
        user.
     */
    case userMismatch

    /** Indicates an attempt to link with a credential that has already been linked with a
        different Firebase account
     */
    case credentialAlreadyInUse

    /** Indicates the App is not authorized to use Firebase Authentication with the
        provided API Key.
     */
    case appNotAuthorized

    /** Indicates the OOB code is expired.
     */
    case expiredActionCode

    /** Indicates the OOB code is invalid.
     */
    case invalidActionCode

    /** Indicates that there are invalid parameters in the payload during a "send password reset
     *  email" attempt.
     */
    case invalidMessagePayload

    /** Indicates that the sender email is invalid during a "send password reset email" attempt.
     */
    case invalidSender

    /** Indicates that the recipient email is invalid.
     */
    case invalidRecipientEmail

    /** Indicates that an email address was expected but one was not provided.
     */
    case missingEmail

    /** Indicates that the iOS bundle ID is missing when a iOS App Store ID is provided.
     */
    case missingIosBundleID

    /** Indicates that the domain specified in the continue URL is not allowlisted in the Firebase
        console.
     */
    case unauthorizedDomain

    /** Indicates that the domain specified in the continue URI is not valid.
     */
    case invalidContinueURI

    /** Indicates that a continue URI was not provided in a request to the backend which requires
        one.
     */
    case missingContinueURI

    /** Indicates that a phone number was not provided in a call to
        `verifyPhoneNumber:completion:`.
     */
    case missingPhoneNumber

    /** Indicates that an invalid phone number was provided in a call to
        `verifyPhoneNumber:completion:`.
     */
    case invalidPhoneNumber

    /** Indicates that the phone auth credential was created with an empty verification code.
     */
    case missingVerificationCode

    /** Indicates that an invalid verification code was used in the verifyPhoneNumber request.
     */
    case invalidVerificationCode

    /** Indicates that the phone auth credential was created with an empty verification ID.
     */
    case missingVerificationID

    /** Indicates that an invalid verification ID was used in the verifyPhoneNumber request.
     */
    case invalidVerificationID

    /** Indicates that the APNS device token is missing in the verifyClient request.
     */
    case missingAppCredential

    /** Indicates that an invalid APNS device token was used in the verifyClient request.
     */
    case invalidAppCredential

    /** Indicates that the SMS code has expired.
     */
    case sessionExpired

    /** Indicates that the quota of SMS messages for a given project has been exceeded.
     */
    case quotaExceeded

    /** Indicates that the APNs device token could not be obtained. The app may not have set up
        remote notification correctly, or may fail to forward the APNs device token to Auth
        if app delegate swizzling is disabled.
     */
    case missingAppToken

    /** Indicates that the app fails to forward remote notification to Auth.
     */
    case notificationNotForwarded

    /** Indicates that the app could not be verified by Firebase during phone number authentication.
     */
    case appNotVerified

    /** Indicates that the reCAPTCHA token is not valid.
     */
    case captchaCheckFailed

    /** Indicates that an attempt was made to present a new web context while one was already being
        presented.
     */
    case webContextAlreadyPresented

    /** Indicates that the URL presentation was cancelled prematurely by the user.
     */
    case webContextCancelled

    /** Indicates a general failure during the app verification flow.
     */
    case appVerificationUserInteractionFailure

    /** Indicates that the clientID used to invoke a web flow is invalid.
     */
    case invalidClientID

    /** Indicates that a network request within a SFSafariViewController or WKWebView failed.
     */
    case webNetworkRequestFailed

    /** Indicates that an internal error occurred within a SFSafariViewController or WKWebView.
     */
    case webInternalError

    /** Indicates a general failure during a web sign-in flow.
     */
    case webSignInUserInteractionFailure

    /** Indicates that the local player was not authenticated prior to attempting Game Center
        signin.
     */
    case localPlayerNotAuthenticated

    /** Indicates that a non-null user was expected as an argmument to the operation but a null
        user was provided.
     */
    case nullUser

    /** Indicates that a Firebase Dynamic Link is not activated.
     */
    case dynamicLinkNotActivated

    /**
     * Represents the error code for when the given provider id for a web operation is invalid.
     */
    case invalidProviderID

    /**
     * Represents the error code for when an attempt is made to update the current user with a
     * tenantId that differs from the current FirebaseAuth instance's tenantId.
     */
    case tenantIDMismatch

    /**
     * Represents the error code for when a request is made to the backend with an associated tenant
     * ID for an operation that does not support multi-tenancy.
     */
    case unsupportedTenantOperation

    /** Indicates that the Firebase Dynamic Link domain used is either not configured or is
        unauthorized for the current project.
     */
    case invalidDynamicLinkDomain

    /** Indicates that the credential is rejected because it's misformed or mismatching.
     */
    case rejectedCredential

    /** Indicates that the GameKit framework is not linked prior to attempting Game Center signin.
     */
    case gameKitNotLinked

    /** Indicates that the second factor is required for signin.
     */
    case secondFactorRequired

    /** Indicates that the multi factor session is missing.
     */
    case missingMultiFactorSession

    /** Indicates that the multi factor info is missing.
     */
    case missingMultiFactorInfo

    /** Indicates that the multi factor session is invalid.
     */
    case invalidMultiFactorSession

    /** Indicates that the multi factor info is not found.
     */
    case multiFactorInfoNotFound

    /** Indicates that the operation is admin restricted.
     */
    case adminRestrictedOperation

    /** Indicates that the email is required for verification.
     */
    case unverifiedEmail

    /** Indicates that the second factor is already enrolled.
     */
    case secondFactorAlreadyEnrolled

    /** Indicates that the maximum second factor count is exceeded.
     */
    case maximumSecondFactorCountExceeded

    /** Indicates that the first factor is not supported.
     */
    case unsupportedFirstFactor

    /** Indicates that the a verifed email is required to changed to.
     */
    case emailChangeNeedsVerification

    /** Indicates that the nonce is missing or invalid.
     */
    case missingOrInvalidNonce

    /** Indicates an error for when the client identifier is missing.
     */
    case missingClientIdentifier

    /** Indicates an error occurred while attempting to access the keychain.
     */
    case keychainError

    /** Indicates an internal error occurred.
     */
    case internalError

    /** Raised when a JWT fails to parse correctly. May be accompanied by an underlying error
        describing which step of the JWT parsing process failed.
     */
    case malformedJWT
    
    var errorCode: Int {
        switch self {
            
        case .defaultError: return 0
        case .userRecordNotFound: return 1
        
        case .invalidCustomToken: return 17000
        case .customTokenMismatch: return 17002
        case .invalidCredential: return 17004
        case .userDisabled: return 17005
        case .operationNotAllowed: return 17006
        case .invalidEmail: return 17008
        case .wrongPassword: return 17009
        case .tooManyRequests: return 17010
        case .userNotFound: return 17011
        case .accountExistsWithDifferentCredential: return 17012
        case .requiresRecentLogin: return 17014
        case .providerAlreadyLinked: return 17015
        case .noSuchProvider: return 17016
        case .invalidUserToken: return 17017
        case .networkError: return 17020
        case .userTokenExpired: return 17021
        case .invalidAPIKey: return 17023
        case .userMismatch: return 17024
        case .credentialAlreadyInUse: return 17025
        case .appNotAuthorized: return 17028
        case .expiredActionCode: return 17029
        case .invalidActionCode: return 17030
        case .invalidMessagePayload: return 17031
        case .invalidSender: return 17032
        case .invalidRecipientEmail: return 17033
        case .missingEmail: return 17034
        case .missingIosBundleID: return 17036
        case .unauthorizedDomain: return 17038
        case .invalidContinueURI: return 17039
        case .missingContinueURI: return 17040
        case .missingPhoneNumber: return 17041
        case .invalidPhoneNumber: return 17042
        case .missingVerificationCode: return 17043
        case .invalidVerificationCode: return 17044
        case .missingVerificationID: return 17045
        case .invalidVerificationID: return 17046
        case .missingAppCredential: return 17047
        case .invalidAppCredential: return 17048
        case .sessionExpired: return 17051
        case .quotaExceeded: return 17052
        case .missingAppToken: return 17053
        case .notificationNotForwarded: return 17054
        case .appNotVerified: return 17055
        case .captchaCheckFailed: return 17056
        case .webContextAlreadyPresented: return 17057
        case .webContextCancelled: return 17058
        case .appVerificationUserInteractionFailure: return 17059
        case .invalidClientID: return 17060
        case .webNetworkRequestFailed: return 17061
        case .webInternalError: return 17062
        case .webSignInUserInteractionFailure: return 17063
        case .localPlayerNotAuthenticated: return 17066
        case .nullUser: return 17067
        case .dynamicLinkNotActivated: return 17068
        case .invalidProviderID: return 17071
        case .tenantIDMismatch: return 17072
        case .unsupportedTenantOperation: return 17073
        case .invalidDynamicLinkDomain: return 17074
        case .rejectedCredential: return 17075
        case .gameKitNotLinked: return 17076
        case .secondFactorRequired: return 17078
        case .missingMultiFactorSession: return 17081
        case .missingMultiFactorInfo: return 17082
        case .invalidMultiFactorSession: return 17083
        case .multiFactorInfoNotFound: return 17084
        case .adminRestrictedOperation: return 17085
        case .unverifiedEmail: return 17086
        case .secondFactorAlreadyEnrolled: return 17087
        case .maximumSecondFactorCountExceeded: return 17088
        case .unsupportedFirstFactor: return 17089
        case .emailChangeNeedsVerification: return 17090
        case .missingOrInvalidNonce: return 17094
        case .missingClientIdentifier: return 17993
        case .keychainError: return 17995
        case .internalError: return 17999
        case .malformedJWT: return 18000
        }
    }
    
    var description: String {
        switch self {
        case .userRecordNotFound: return
            "Account data not found"
        case .defaultError: return
            "There was an error, please try again later"
        case .userNotFound: return
            "No user found with this email. Check if the entered data is correct"
        case .wrongPassword: return
            "Invalid password. Check if the entered data is correct"
        default: return ""
        }
    }
}
