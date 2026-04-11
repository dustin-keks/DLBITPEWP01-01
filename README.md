# Full-Stack E-Commerce Application

A full-stack e-commerce web application built with **Angular** (frontend) and **Spring Boot** (backend), using a **MySQL** database.

---

## Database Setup

Import the SQL dump included in the root of this project. The database, user, and all tables with seed data will be created automatically:

```bash
mysql -u root -p < ecommerce-database.sql
```

---

## Backend Setup (Spring Boot)

Navigate to the `ecommerce` directory and start the backend server:

```bash
cd ecommerce
./mvnw spring-boot:run
```

The backend API will be available at: `http://localhost:8080/api`

---

## Frontend Setup (Angular)

Navigate to the `client` directory, install dependencies, and start the dev server:

```bash
cd client
npm install
ng serve
```

The frontend will be available at: `http://localhost:4200`