//
//  Created by Alex Vlasov.
//  Copyright © 2018 Alex Vlasov. All rights reserved.
//

import Foundation
import BigInt
import Web3Core

extension Web3.Personal {

    /// Locally or remotely sign a message (arbitrary data) with the private key.
    /// To avoid potential signing of a transaction the message is first prepended by a special header and then hashed.
    /// - Parameters:
    ///   - message: raw message as bytes (e.g. UTF-8 bytes of a string);
    ///   - from: an account whose private key will be used;
    ///   - password: password to extract private key;
    /// - Returns: signed personal message
    public func signPersonalMessage(message: Data, from: EthereumAddress, password: String) async throws -> Data {
        let result = try await signPersonal(message: message, from: from, password: password)
        return result
    }

    /// Unlock an account on the remote node to be able to send transactions and sign messages.
    /// - Parameters:
    ///   - account: EthereumAddress of the account to unlock
    ///   - password: Password for the account
    ///   - seconds: Time interval before automatic account lock by Ethereum node. Default 300
    /// - Returns: `true` if account was unlocked.
    public func unlockAccount(account: EthereumAddress, password: String, seconds: UInt = 300) async throws -> Bool {
        let result = try await unlock(account: account, password: password)
        return result
    }

    /// Recovers a signer of some personal message. Message will be first prepended by special prefix
    /// (check the "signPersonalMessage" method description) and then hashed before the recovery attempt.
    ///
    /// If you have a hash instead of a message use ``Web3/Personal/ecrecover(hash:signature:)``
    ///
    /// - Parameters:
    ///   - personalMessage: raw message as bytes (e.g. UTF-8 bytes of a string);
    ///   - signature: signature that is the result of signing the `personalMessage`;
    /// - Returns: address of the signer or `nil`.
    public func ecrecover(personalMessage: Data, signature: Data) -> EthereumAddress? {
        Utilities.personalECRecover(personalMessage, signature: signature)
    }

    /// Recovers a signer of some hash.
    /// - Parameters:
    ///   - hash: some hash, e.g. hashed personal message;
    ///   - signature: 65 bytes serialized signature;
    /// - Returns: address of the signer or `nil`.
    public func ecrecover(hash: Data, signature: Data) -> EthereumAddress {
        Utilities.hashECRecover(hash: hash, signature: signature)
    }
}
