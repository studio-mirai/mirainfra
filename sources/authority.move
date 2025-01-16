module mirainfra::authority;

use std::string::String;

//=== Structs ===

public struct Authority has key {
    id: UID,
    network: String,
    service: String,
    version: String,
}

public struct AuthorityCap has key {
    id: UID,
    authority_id: ID,
}

//=== Errors ===

const EInvalidAuthorityCap: u64 = 0;

//=== Public Functions ===

public fun new(network: String, service: String, version: String, ctx: &mut TxContext) {
    let authority = Authority {
        id: object::new(ctx),
        network: network,
        service: service,
        version: version,
    };

    transfer::share_object(authority);
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

public fun service(self: &Authority): String {
    self.service
}

public fun version(self: &Authority): String {
    self.version
}
