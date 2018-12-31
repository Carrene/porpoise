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
            case 500:
                self?.view.showServerError()
            default:
                UIHelper.showFailedSnackBar()
            }
        }
        userRepostiory.claim(user: user, onDone: onDataResponse)
    }
    
    func getBankList(){
        let banks = [Bank(name:"آینده")]
        view.setBankList(banks: banks)
    }
    
    func getUser(bank: Bank) {
        let repository = UserRepository()
        let onDataResponse : ((RepositoryResponse<User>) -> ()) = { [weak self] response in
            
                print(response.value)
            
        }
        repository.get(bank: bank, onDone: onDataResponse)
    }
    
    
}
