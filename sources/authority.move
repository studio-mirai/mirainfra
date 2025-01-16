module mirainfra::authority;

use std::string::String;

//=== Structs ===

public struct Authority has key {
    id: UID,
    network: String,
    environment: String,
    service: String,
    version: String,
}

public struct AuthorityCap has key, store {
    id: UID,
    authority_id: ID,
}

//=== Errors ===

const EInvalidAuthorityCap: u64 = 0;

//=== Public Functions ===

public fun new(
    network: String,
    environment: String,
    service: String,
    version: String,
    ctx: &mut TxContext,
): AuthorityCap {
    let authority = Authority {
        id: object::new(ctx),
        network: network,
        environment: environment,
        service: service,
        version: version,
    };

    let authority_cap = AuthorityCap {
        id: object::new(ctx),
        authority_id: authority.id(),
    };

    transfer::share_object(authority);

    authority_cap
}

public fun destroy(cap: AuthorityCap, self: Authority) {
    let Authority { id, .. } = self;
    id.delete();

    let AuthorityCap { id, .. } = cap;
    id.delete();
}

public fun update_version(self: &mut Authority, cap: &AuthorityCap, version: String) {
    assert!(cap.authority_id == self.id(), EInvalidAuthorityCap);
    self.version = version;
}

//== View Functions ===

public fun id(self: &Authority): ID {
    self.id.to_inner()
}

public fun network(self: &Authority): String {
    self.network
}

public fun environment(self: &Authority): String {
    self.environment
}

public fun service(self: &Authority): String {
    self.service
}

public fun version(self: &Authority): String {
    self.version
}
