//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare
import StoreKit

final class IAPProviderMock: IIAPProvider {
    var invokedCanMakePayments = false
    var invokedCanMakePaymentsCount = 0
    var stubbedCanMakePayments: Bool = false

    var canMakePayments: Bool {
        invokedCanMakePayments = true
        invokedCanMakePaymentsCount += 1
        return stubbedCanMakePayments
    }

    var invokedFetch = false
    var invokedFetchCount = 0
    var invokedFetchParameters: (productsIds: Set<String>, completion: Closure<Result<[SKProduct], IAPError>>)?
    var invokedFetchParametersList = [(productsIds: Set<String>, completion: Closure<Result<[SKProduct], IAPError>>)]()

    func fetch(productsIds: Set<String>, completion: @escaping Closure<Result<[SKProduct], IAPError>>) {
        invokedFetch = true
        invokedFetchCount += 1
        invokedFetchParameters = (productsIds, completion)
        invokedFetchParametersList.append((productsIds, completion))
    }

    var invokedPurchase = false
    var invokedPurchaseCount = 0
    var invokedPurchaseParameters: (productId: String, completion: Closure<Result<PaymentTransaction, IAPError>>)?
    var invokedPurchaseParametersList = [(productId: String, completion: Closure<Result<PaymentTransaction, IAPError>>)]()

    func purchase(productId: String, completion: @escaping Closure<Result<PaymentTransaction, IAPError>>) {
        invokedPurchase = true
        invokedPurchaseCount += 1
        invokedPurchaseParameters = (productId, completion)
        invokedPurchaseParametersList.append((productId, completion))
    }

    var invokedRefreshReceipt = false
    var invokedRefreshReceiptCount = 0
    var invokedRefreshReceiptParameters: (Closure<Result<String, IAPError>>, Void)?
    var invokedRefreshReceiptParametersList = [(Closure<Result<String, IAPError>>, Void)]()
    var stubbedRefreshReceiptResult: Result<String, IAPError>?

    func refreshReceipt(completion: @escaping Closure<Result<String, IAPError>>) {
        invokedRefreshReceipt = true
        invokedRefreshReceiptCount += 1
        invokedRefreshReceiptParameters = (completion, ())
        invokedRefreshReceiptParametersList.append((completion, ()))

        if let result = stubbedRefreshReceiptResult {
            completion(result)
        }
    }

    var invokedFinishTransaction = false
    var invokedFinishTransactionCount = 0
    var invokedFinishTransactionParameters: (PaymentTransaction, Void)?
    var invokedFinishTransactionParanetersList = [(PaymentTransaction, Void)]()

    func finish(transaction: PaymentTransaction) {
        invokedFinishTransaction = true
        invokedFinishTransactionCount += 1
        invokedFinishTransactionParameters = (transaction, ())
        invokedFinishTransactionParanetersList.append((transaction, ()))
    }

    var invokedAddTransactionObserver = false
    var invokedAddTransactionObserverCount = 0
    var invokedAddTransactionObserverParameters: (fallbackHandler: Closure<Result<PaymentTransaction, IAPError>>?, Void)?
    var invokedAddTransactionObserverParametersList = [(fallbackHandler: Closure<Result<PaymentTransaction, IAPError>>?, Void)]()

    func addTransactionObserver(fallbackHandler: Closure<Result<PaymentTransaction, IAPError>>?) {
        invokedAddTransactionObserver = true
        invokedAddTransactionObserverCount += 1
        invokedAddTransactionObserverParameters = (fallbackHandler, ())
        invokedAddTransactionObserverParametersList.append((fallbackHandler, ()))
    }

    var invokedRemoveTransactionObserver = false
    var invokedRemoveTransactionObserverCount = 0

    func removeTransactionObserver() {
        invokedRemoveTransactionObserver = true
        invokedRemoveTransactionObserverCount += 1
    }

    var invokedFetchAsync = false
    var invokedFetchAsyncCount = 0
    var invokedFetchAsyncParameters: (productIDs: Set<String>, Void)?
    var invokedFetchAsyncParametersList = [(productIDs: Set<String>, Void)]()
    var fetchAsyncResult: [SKProduct] = []

    func fetch(productsIDs: Set<String>) async throws -> [SKProduct] {
        invokedFetchAsync = true
        invokedFetchAsyncCount += 1
        invokedFetchAsyncParameters = (productsIDs, ())
        invokedFetchAsyncParametersList.append((productsIDs, ()))
        return fetchAsyncResult
    }

    var invokedAsyncPurchase = false
    var invokedAsyncPurchaseCount = 0
    var invokedAsyncPurchaseParameters: (productID: String, Void)?
    var invokedAsyncPurchaseParametersList = [(productID: String, Void)?]()
    var stubbedAsyncPurchase: PaymentTransaction!

    func purchase(productId: String) async throws -> PaymentTransaction {
        invokedAsyncPurchase = true
        invokedAsyncPurchaseCount += 1
        invokedAsyncPurchaseParameters = (productId, ())
        invokedAsyncPurchaseParametersList.append((productId, ()))
        return stubbedAsyncPurchase
    }

    var invokedAsyncRefreshReceipt = false
    var invokedAsyncRefreshReceiptCounter = 0
    var stubbedRefreshReceiptAsyncResult: Result<String, IAPError>!

    func refreshReceipt() async throws -> String {
        invokedAsyncRefreshReceipt = true
        invokedAsyncRefreshReceiptCounter += 1

        let result = stubbedRefreshReceiptAsyncResult

        switch result {
        case let .success(receipt):
            return receipt
        case let .failure(error):
            throw error
        default:
            fatalError("An unknown type")
        }
    }
}
