import Foundation

    protocol PhoneInputViewProtocol: class {
        func showBadRequestError()
        func showServerError()
        func setBankList(banks: [Bank])
        func navigateToPhoneConfirmation(phone:String)
        func showAlreadyRegistered(phone:String)
        func showPhoneInput()
    }

    protocol PhoneInputPresenterProtocol {
        init(view: PhoneInputViewProtocol)
        func claim(phone: String, bank:Bank)
        func getBankList()
        func getUser(bank:Bank)
    }
