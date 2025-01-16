module mirainfra::authority;

use std::string::String;
use sui::event::emit;

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

//=== Events ===

public struct AuthorityCreatedEvent has copy, drop {
    authority_id: ID,
    authority_cap_id: ID,
    network: String,
    environment: String,
    service: String,
    version: String,
}

public struct AuthorityDestroyedEvent has copy, drop {
    authority_id: ID,
}

public struct AuthorityUpdatedEvent has copy, drop {
    authority_id: ID,
    version: String,
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

    emit(AuthorityCreatedEvent {
        authority_id: authority.id(),
        authority_cap_id: authority_cap.id.to_inner(),
        network: authority.network,
        environment: authority.environment,
        service: authority.service,
        version: authority.version,
    });

    transfer::share_object(authority);

    authority_cap
}

public fun destroy(cap: AuthorityCap, self: Authority) {
    emit(AuthorityDestroyedEvent {
        authority_id: self.id(),
    });

    let Authority { id, .. } = self;
    id.delete();

    let AuthorityCap { id, .. } = cap;
    id.delete();
}

public fun update_version(self: &mut Authority, cap: &AuthorityCap, version: String) {
    assert!(cap.authority_id == self.id(), EInvalidAuthorityCap);

    let from_version = self.version;

    self.version = version;

    emit(AuthorityUpdatedEvent {
        authority_id: self.id(),
        from_version: from_version,
        to_version: self.version,
    });
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
