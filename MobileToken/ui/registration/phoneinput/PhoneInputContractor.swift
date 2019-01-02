import Foundation

    protocol PhoneInputViewProtocol: class {
        func showBadRequestError()
        func showServerError()
        func setBankList(banks: [Bank])
        func navigateToPhoneConfirmation(phone:String)
        func showAlreadyRegistered()
        func showPhoneInput()
    }

    protocol PhoneInputPresenterProtocol {
        init(view: PhoneInputViewProtocol)
        func claim(phone: String, bank:Bank)
        func getBankList()
        func getUser(bank:Bank)
    }
