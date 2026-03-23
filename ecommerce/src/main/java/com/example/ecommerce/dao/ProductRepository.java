package com.example.ecommerce.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import com.example.ecommerce.entity.Product;

@RepositoryRestResource
public interface ProductRepository extends JpaRepository<Product, Long>{
    // product list
    Page<Product> findByCategoryId(@Param("id") Long id, Pageable pageable);

    // product search
    Page<Product> findByNameContaining(@Param("name") String name, Pageable pageable);

    // product list ... only active products
    Page<Product> findByCategoryIdAndActiveTrue(@Param("id") Long id, Pageable pageable);

    // product search ... only active products
    Page<Product> findByNameContainingAndActiveTrue(@Param("name") String name, Pageable pageable);
}
