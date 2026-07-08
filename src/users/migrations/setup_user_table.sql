-- CREATE USER TABLE
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    password VARCHAR(128),
    last_login INTEGER,
    is_super_user BOOLEAN DEFAULT 0 CHECK (is_super_user IN (0, 1)),
    is_staff BOOLEAN DEFAULT 0 CHECK (is_staff IN (0, 1)),
    is_active BOOLEAN DEFAULT 0 CHECK (is_active IN (0, 1)),
    date_joined INTEGER, 
    name VARCHAR(200) CHECK (LENGTH(name) <= 200),
    username VARCHAR(16) UNIQUE CHECK (LENGTH(username) <= 16),
    email VARCHAR(255) UNIQUE CHECK(LENGTH(email) <= 255),
    role VARCHAR(50) CHECK(role IN ('user', 'employee', 'admin')),
    created_at INTEGER,
    updated_at INTEGER
);

CREATE TABLE IF NOT EXISTS user_profiles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL UNIQUE,
    is_deleted BOOLEAN DEFAULT 0 CHECK (is_deleted IN (0,1)),
    permission_obj TEXT,
    created_at INTEGER,
    updated_at INTEGER,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
--
