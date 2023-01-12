//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import StoreKit

final class ProductMock: SKProduct {
    var invokedProductIdentifier = false
    var invokedProductIdentifierCount = 0
    var stubbedProductIdentifier: String!

    override var productIdentifier: String {
        invokedProductIdentifier = true
        invokedProductIdentifierCount += 1
        return stubbedProductIdentifier
    }
}
