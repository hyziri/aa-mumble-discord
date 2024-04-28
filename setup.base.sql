CREATE USER 'aauth'@'%' IDENTIFIED BY '8d35883e8bd5e96f315884553b9fb43adf332bd61ebf38a5';
CREATE DATABASE alliance_auth CHARACTER SET utf8mb4;
CREATE DATABASE alliance_mumble CHARACTER SET utf8mb4;
GRANT ALL PRIVILEGES ON alliance_auth.* TO 'aauth'@'%';
GRANT ALL PRIVILEGES ON alliance_mumble.* TO 'aauth'@'%';
GRANT
SELECT,
    SHOW VIEW ON alliance_auth.* TO 'grafana'@'%';
