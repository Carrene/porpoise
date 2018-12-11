

import Foundation

class PhoneInputPresenter : PhoneInputPresenterProtocol {

    var userRepostiory = UserRepository()

    unowned let view: PhoneInputViewProtocol
    
    required init(view: PhoneInputViewProtocol) {
        self.view = view
    }
    
    func claim(phone: String) {
        let user = User(phone: phone)
        let onDataResponse: ((RepositoryResponse<User>) -> ()) = { [weak self] response in
            let statusCode = response.restDataResponse?.response?.statusCode
            switch statusCode {
            case 200:
                self?.view.navigateToPhoneConfirmation(phone:phone)
            case 400:
                self?.view.showBadRequestError()
            default:
                UIHelper.showFailedSnackBar()
            }
        }
        userRepostiory.claim(user: user, onDone: onDataResponse)
    }
    
    func getBankList() -> [Bank]{
        var bankList = [Bank(name:"آینده")]
        return bankList
    }
    
}
