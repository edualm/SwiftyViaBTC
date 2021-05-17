# SwiftyViaBTC

ViaBTC API for usage from within Swift.

For now, only a handful of API methods are implemented.

## Requirements

Any platform that supports Swift 5+.

## Installation

This package can be imported using Swift Package Manager.

## Example Usage

```
import SwiftyViaBTC

let apiKey = "<Your API Key>"

let connection = ViaBTCConnection(apiKey: apiKey)

connection.acquireHashrate { result in
    switch result {
    case .success(let hashRate):
        let hashRateMHs = $0.hashrate24Hour / 1_000_000
        
        print("[\($0.activeWorkers)] Hash Rate: \(hashRateMHs) MH/s")
        
    case .failure(let error):
        print(error)
    }
}
```
