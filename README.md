# Mirainfra

Mirainfra is a basic infrastructure coordination primitive built on Sui. It lets users create `Authority` objects which can be used to initiate infrastructure updates.

An `Authority` objects looks like this:

```
public struct Authority has key {
    id: UID,
    network: String,
    service: String,
    version: String,
}
```

When creating an `Authority` object, you must provide a `network`, `service`, and `version` values.

For example, a Sui mainnet validator node could use the values below:

* `network`: `sui-mainnet`
* `service`: `validator`
* `version`: `fea2f2707d4a8c545879da8df76ee5392fa63364`

he validator node can run a cron job to fetch its assigned `Authority` object and determine whether it needs to update.