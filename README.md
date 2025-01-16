# Mirainfra

Mirainfra is a basic infrastructure coordination primitive built on Sui. It lets users create `Authority` objects which can be used to initiate infrastructure updates.

An `Authority` objects looks like this:

```
public struct Authority has key {
    id: UID,
    network: String,
    environment: String,
    service: String,
    version: String,
}
```

When creating an `Authority` object, you must provide a `network`, `service`, and `version` values.

For example, a Sui mainnet validator node could use the values below:

* `network`: `sui`
* `environment`: `mainnet`
* `service`: `validator`
* `version`: `fea2f2707d4a8c545879da8df76ee5392fa63364`

The validator node can run a cron job to fetch its assigned `Authority` object and determine whether it needs to update.

# How to Use Miraifra

The `mirainfra` package is currently deployed on Sui mainnet. Refer to `/package/Move.lock` for the current Package ID.

Scripts to manage `Authority` objects are provided in the `/scripts` directory.

## Create an Authority.

```
PACKAGE_ID=<PACKAGE_ID> ./scripts/create_authority.sh <NETWORK> <ENVIRONMENT> <SERVICE> <VERSION>
```

## View an Authority.

```
./scripts/view_authority.sh <AUTHORITY_ID>
```

## Update an Authority.

```
PACKAGE_ID=<PACKAGE_ID> ./scripts/update_authority.sh <AUTHORITY_ID> <AUTHORITY_CAP_ID> <VERSION>
```

## Destroy an Authority.

```
PACKAGE_ID=<PACKAGE_ID> ./scripts/destroy_authority.sh <AUTHORITY_ID> <AUTHORITY_CAP_ID>
```
