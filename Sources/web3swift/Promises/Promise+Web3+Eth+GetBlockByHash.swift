//  web3swift
//
//  Created by Alex Vlasov.
//  Copyright © 2018 Alex Vlasov. All rights reserved.
//

import Foundation
import BigInt


extension web3.Eth {
    public func block(by hash: Data, fullTransactions: Bool = false) async throws -> Block {
        let hashString = hash.toHexString().addHexPrefix()
        return try await block(by: hashString, fullTransactions: fullTransactions)
    }

    public func block(by hash: String, fullTransactions: Bool = false) async throws -> Block {
        let requestCall: APIRequest = .getBlockByHash(hash, fullTransactions)
        let response: APIResponse<Block> = try await APIRequest.sendRequest(with: self.provider, for: requestCall)
        return response.result
    }
}
