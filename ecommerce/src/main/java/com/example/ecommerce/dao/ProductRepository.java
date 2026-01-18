package com.example.ecommerce.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.ecommerce.entity.Product;

public interface ProductRepository extends JpaRepository<Product, Long>{

}
