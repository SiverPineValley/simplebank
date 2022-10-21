CREATE TABLE accounts
(
    id         serial PRIMARY KEY,
    owner      varchar(100) NOT NULL,
    balance    bigint       NOT NULL,
    currency   varchar(100) NOT NULL,
    created_at timestamp    NOT NULL DEFAULT (now())
);


CREATE TABLE entries
(
    id         serial PRIMARY KEY,
    account_id bigint UNSIGNED NOT NULL,
    amount     bigint    NOT NULL COMMENT 'can be negative or positive',
    created_at timestamp NOT NULL DEFAULT (now())
);

CREATE TABLE transfers
(
    id              serial PRIMARY KEY,
    from_account_id bigint UNSIGNED NOT NULL,
    to_account_id   bigint UNSIGNED NOT NULL,
    amount          bigint    NOT NULL COMMENT 'must be positive',
    created_at      timestamp NOT NULL DEFAULT (now())
);

ALTER TABLE entries
    ADD FOREIGN KEY (account_id) REFERENCES accounts (id);

ALTER TABLE transfers
    ADD FOREIGN KEY (from_account_id) REFERENCES accounts (id);

ALTER TABLE transfers
    ADD FOREIGN KEY (to_account_id) REFERENCES accounts (id);

CREATE
INDEX index_accounts_owner ON accounts (owner);

CREATE
INDEX index_entries_account_id ON entries (account_id);

CREATE
INDEX index_transfers_from_account_id ON transfers (from_account_id);

CREATE
INDEX index_transfers_to_account_id ON transfers (to_account_id);

CREATE
INDEX index_transfers_from_to_account_id ON transfers (from_account_id, to_account_id);
