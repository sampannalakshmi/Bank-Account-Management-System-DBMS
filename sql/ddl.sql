CREATE DATABASE bank_account_management;

USE bank_account_management;
CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    address VARCHAR(255),
    id_number VARCHAR(30) UNIQUE NOT NULL
);
CREATE TABLE branch (
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    ifsc_code VARCHAR(20) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL
);
CREATE TABLE account_type (
    account_type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(30) UNIQUE NOT NULL,
    minimum_balance DECIMAL(12,2) NOT NULL,
    interest_rate DECIMAL(5,2) NOT NULL
);
CREATE TABLE account (
    account_no BIGINT PRIMARY KEY,
    customer_id INT NOT NULL,
    account_type_id INT NOT NULL,
    branch_id INT NOT NULL,
    balance DECIMAL(12,2) DEFAULT 0.00,
    status VARCHAR(20) DEFAULT 'Active',
    opening_date DATE NOT NULL,

    FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id),

    FOREIGN KEY (account_type_id)
        REFERENCES account_type(account_type_id),

    FOREIGN KEY (branch_id)
        REFERENCES branch(branch_id),

    CHECK (balance >= 0)
);
CREATE TABLE bank_transaction (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_no BIGINT NOT NULL,
    transaction_type VARCHAR(20) NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    description VARCHAR(255),

    FOREIGN KEY (account_no)
        REFERENCES account(account_no),

    CHECK (amount > 0),
    CHECK (transaction_type IN ('Deposit', 'Withdrawal', 'Transfer'))
);
CREATE TABLE employee (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_id INT NOT NULL,
    employee_name VARCHAR(100) NOT NULL,
    designation VARCHAR(50) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,

    FOREIGN KEY (branch_id)
        REFERENCES branch(branch_id)
);
CREATE TABLE loan (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    loan_type VARCHAR(50) NOT NULL,
    loan_amount DECIMAL(12,2) NOT NULL,
    interest_rate DECIMAL(5,2) NOT NULL,
    loan_date DATE NOT NULL,
    loan_status VARCHAR(20) DEFAULT 'Active',

    FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id),

    CHECK (loan_amount > 0),
    CHECK (interest_rate >= 0),
    CHECK (loan_status IN ('Active', 'Closed', 'Pending'))
);
CREATE TABLE loan_payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    loan_id INT NOT NULL,
    payment_amount DECIMAL(12,2) NOT NULL,
    payment_date DATE NOT NULL,
    payment_mode VARCHAR(30) NOT NULL,

    FOREIGN KEY (loan_id)
        REFERENCES loan(loan_id),

    CHECK (payment_amount > 0),
    CHECK (payment_mode IN ('Cash', 'UPI', 'Card', 'Bank Transfer'))
);
