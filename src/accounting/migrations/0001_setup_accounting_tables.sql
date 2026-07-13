CREATE TABLE IF NOT EXISTS account_heads (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type VARCHAR(50) CHECK(LENGTH(type) <= 50),
    created_at INTEGER DEFAULT (UNIXEPOCH()),
    updated_at INTEGER DEFAULT (UNIXEPOCH())
);

CREATE TABLE IF NOT EXISTS accounts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) CHECK(LENGTH(name) <= 255),
    email VARCHAR(255) CHECK(LENGTH(email) <= 255),
    type VARCHAR(255) CHECK(type IN ('sale', 'purchase', 'others') AND LENGTH(type) <= 255),
    contact_no VARCHAR(20) CHECK(LENGTH(contact_no) <= 20),
    address VARCHAR(255) CHECK(LENGTH(address) <= 255),
    contact_person VARCHAR(255) CHECK(LENGTH(contact_person) <= 255),
    account_heads_id INTEGER,
    created_at INTEGER DEFAULT (UNIXEPOCH()),
    updated_at INTEGER DEFAULT (UNIXEPOCH()),
    FOREIGN KEY (account_heads_id) REFERENCES account_heads(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS voucher_types (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type VARCHAR(255) NOT NULL UNIQUE,
    prefix VARCHAR(255) NOT NULL UNIQUE,
    created_at INTEGER DEFAULT (UNIXEPOCH()),
    updated_at INTEGER DEFAULT (UNIXEPOCH())
);

CREATE TABLE IF NOT EXISTS vouchers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    cheque_number VARCHAR(255) CHECK(LENGTH(cheque_number) <= 255),
    cheque_date INTEGER,
    bank_name VARCHAR(150) CHECK(LENGTH(bank_name) <= 150),
    voucher_number VARCHAR(100) CHECK(LENGTH(voucher_number) <= 100),
    voucher_category VARCHAR(150) CHECK(LENGTH(voucher_category) <= 150 AND voucher_category IN ('profit_loss', 'manual')),
    narration TEXT,
    created_at INTEGER DEFAULT (UNIXEPOCH()),
    updated_at INTEGER DEFAULT (UNIXEPOCH())
);
 
CREATE TABLE IF NOT EXISTS voucher_transactions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date INTEGER,
    remark TEXT,
    debit VARCHAR(100),
    credit VARCHAR(100),
    voucher_id INTEGER,
    account_id INTEGER,
    FOREIGN KEY (voucher_id) REFERENCES vouchers(id) ON DELETE CASCADE,
    FOREIGN KEY (account_id) REFERENCES accounts(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS financial_periods (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) CHECK(LENGTH(name) <= 255),
    start_date INTEGER,
    end_date INTEGER,
    is_closed BOOLEAN DEFAULT 0 CHECK(is_closed IN (0, 1)),
    is_reopened BOOLEAN DEFAULT 0 CHECK(is_reopened IN (0, 1)),
    profit_loss_account_id INTEGER,
    voucher_id INTEGER,
    created_at INTEGER DEFAULT (UNIXEPOCH()),
    updated_at INTEGER DEFAULT (UNIXEPOCH()),
    FOREIGN KEY (profit_loss_account_id) REFERENCES accounts(id) ON DELETE SET NULL,
    FOREIGN KEY (voucher_id) REFERENCES vouchers(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS account_balance (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    opening_debit VARCHAR(100),
    opening_credit VARCHAR(100),
    tranx_debit VARCHAR(100),
    tranx_credit VARCHAR(100),
    financial_period_id INTEGER,
    created_at INTEGER DEFAULT (UNIXEPOCH()),
    updated_at INTEGER DEFAULT (UNIXEPOCH()),
    FOREIGN KEY (financial_period_id) REFERENCES financial_periods(id) ON DELETE SET NULL
);