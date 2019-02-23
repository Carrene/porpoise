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
            case 502:
                self?.view.showNetworkError()
            default:
                UIHelper.showFailedSnackBar()
            }
        }
        userRepostiory.claim(user: user, onDone: onDataResponse)
    }
    
    func getBankList(){

        let banks = [Bank(name: Bank.BankName.AYANDE, logoResourceId: R.image.colorBankAyandehLogo.name),Bank(name: Bank.BankName.SADERAT, logoResourceId: R.image.bankSaderatLogo.name)]
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
                    self!.view.showAlreadyRegistered(phone: (response.value?.phone)!)
                }
            }
        }
        repository.get(bank: bank, onDone: onDataResponse)
    }
}
