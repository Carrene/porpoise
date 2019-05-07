import Foundation
import ObjectMapper
class PhoneInputPresenter : PhoneInputPresenterProtocol {
    
    var userRepostiory = UserRepository()
    unowned let view: PhoneInputViewProtocol
    
    required init(view: PhoneInputViewProtocol) {
        self.view = view
    }
    
    func claim(phone: String,bank:Bank) {
        self.view.startBarIndicator()
        let user = User(phone: phone, activationCode: nil, bank: bank)
        let onDataResponse: ((RepositoryResponse<User>) -> ()) = { [weak self] response in
            self?.view.endBarIndicator()
            if let statusCode = response.restDataResponse?.response?.statusCode {
                switch statusCode {
                case 200:
                    self?.view.navigateToPhoneConfirmation(phone:phone)
                case 400:
                    self?.view.showBadRequestError()
                case 401:
                    self?.view.showEverywhereError401()
                case 500:
                    self?.view.showServerError()
                case 502:
                    self?.view.showNetworkError()
                default:
                    UIHelper.showFailedSnackBar()
                }
            }
            else {
                //self?.view.showEverywhereFail()
            }
        }
        userRepostiory.claim(user: user, onDone: onDataResponse)
    }
    
    func getBankList(){
        let banks = Mapper<Bank>().mapArray(JSONfile:  "banks.json")
        view.setBankList(banks: banks ?? [Bank]())
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
