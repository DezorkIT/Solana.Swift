import Foundation
import RxSwift

extension Solana {
    internal func serializeTransaction(
        instructions: [TransactionInstruction],
        recentBlockhash: String? = nil,
        signers: [Account],
        feePayer: PublicKey? = nil
    ) -> Single<String> {
        Single.create { emitter in
            self.serializeTransaction(instructions: instructions,
                                      recentBlockhash: recentBlockhash,
                                      signers: signers,
                                      feePayer: feePayer
            ) { result in
                switch result {
                case .success(let transaction):
                    emitter(.success(transaction))
                    return
                case .failure(let error):
                    emitter(.failure(error))
                    return
                }
            }
            return Disposables.create()
        }
    }
}
