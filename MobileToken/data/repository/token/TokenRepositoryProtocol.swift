

import Foundation

protocol TokenRepositoryProtocol: Repository where Model == Token, Identifier == String {
    func delete(tokens: [Token], onDone: ((RepositoryResponse<[Model]>) -> ())?)
}
