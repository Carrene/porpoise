

import Foundation

protocol TokenRepositoryProtocol: Repository where Model == Token, Identifier == String {
    func delete(identifire: Identifier, onDone: ((RepositoryResponse<Model>) -> ())?)
}
