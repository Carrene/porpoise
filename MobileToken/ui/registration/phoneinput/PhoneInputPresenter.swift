import Foundation

class PhoneInputPresenter : PhoneInputPresenterProtocol {
    
    var userRepostiory = UserRepository()
    unowned let view: PhoneInputViewProtocol
    
    required init(view: PhoneInputViewProtocol) {
        self.view = view
    }
    
    func claim(phone: String,bank:Bank) {
        let user = User(phone: phone, activationCode: nil, bank: bank)
        let onDataResponse: ((RepositoryResponse<User>) -> ()) = { [weak self] response in
            let statusCode = response.restDataResponse?.response?.statusCode
            switch statusCode {
            case 200:
                self?.view.navigateToPhoneConfirmation(phone:phone)
            case 400:
                self?.view.showBadRequestError()
            case 500:
                self?.view.showServerError()
            default:
                UIHelper.showFailedSnackBar()
            }
        }
        userRepostiory.claim(user: user, onDone: onDataResponse)
    }
    
    func getBankList(){
        let banks = [Bank(name:"ayande")]
        view.setBankList(banks: banks)
    }
    
    func getUser(bank: Bank) {
        let repository = UserRepository()
        let onDataResponse : ((RepositoryResponse<User>) -> ()) = { [weak self] response in
            if response.error != nil {
                print("error")
            }
            else {
                if response.value == nil {
                    self!.view.showPhoneInput()
                }
                else {
                    self!.view.showAlreadyRegistered()
                }
            }
        }
        repository.get(bank: bank, onDone: onDataResponse)
    }
}
