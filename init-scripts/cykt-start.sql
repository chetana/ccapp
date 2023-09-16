CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- cykt
CREATE USER cykt WITH PASSWORD 'cykt';
CREATE DATABASE cykt;
GRANT CREATE ON DATABASE cykt TO cykt;
ALTER USER cykt WITH SUPERUSER;
\connect cykt;
create schema cykt authorization cykt;
GRANT ALL PRIVILEGES ON DATABASE cykt to cykt;