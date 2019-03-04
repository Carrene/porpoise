import Foundation

    protocol PhoneInputViewProtocol: class {
        func showBadRequestError()
        func showServerError()
        func setBankList(banks: [Bank])
        func navigateToPhoneConfirmation(phone:String)
        func showAlreadyRegistered(phone:String)
        func showPhoneInput()
        func showNetworkError()
        func startBarIndicator()
        func endBarIndicator()
        func showEverywhereError401()
        func showEverywhereFail()
    }

    protocol PhoneInputPresenterProtocol {
        init(view: PhoneInputViewProtocol)
        func claim(phone: String, bank:Bank)
        func getBankList()
        func getUser(bank:Bank)
    }
