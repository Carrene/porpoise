import Foundation

    protocol PhoneInputViewProtocol: class {
        func showBadRequestError()
        func setBankList(banks: [Bank])
        func navigateToPhoneConfirmation(phone:String)
    }

    protocol PhoneInputPresenterProtocol {
        init(view: PhoneInputViewProtocol)
        func claim(phone: String)
        func getBankList()
    }
