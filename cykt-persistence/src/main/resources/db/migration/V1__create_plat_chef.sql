CREATE TABLE if not exists plat
(
    id                  UUID PRIMARY KEY,
    chef_id             UUID,
    name                VARCHAR(255),
    type                VARCHAR(255),
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE  if not exists chef
(
    id          UUID PRIMARY KEY,
    name        VARCHAR(255)
);

alter table plat
    add constraint transaction_fk foreign key (chef_id) references chef (id);
