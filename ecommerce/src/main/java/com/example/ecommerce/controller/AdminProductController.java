package com.example.ecommerce.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.ecommerce.dao.ProductCategoryRepository;
import com.example.ecommerce.dao.ProductRepository;
import com.example.ecommerce.dto.ProductRequest;
import com.example.ecommerce.entity.Product;
import com.example.ecommerce.entity.ProductCategory;

@RestController
@RequestMapping("/api/admin/products")
public class AdminProductController {
    private final ProductRepository productRepository;
    private final ProductCategoryRepository productCategoryRepository;

    public AdminProductController(ProductRepository productRepository, ProductCategoryRepository productCategoryRepository) {
        this.productRepository = productRepository;
        this.productCategoryRepository = productCategoryRepository;
    }

    // return all products
    @GetMapping
    public List<Product> getAll() {
        return productRepository.findAll();
    }

    // return a single product or 404
    @GetMapping("/{id}")
    public ResponseEntity<Product> getById(@PathVariable Long id) {
        Optional<Product> result = productRepository.findById(id);

        if (result.isPresent()) {
            return ResponseEntity.ok(result.get());
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    // create a new product
    @PostMapping
    public ResponseEntity<Product> create(@RequestBody ProductRequest request) {
        // find the category by id
        ProductCategory productCategory = productCategoryRepository.findById(request.getCategoryId()).orElse(null);

        if (productCategory == null) {
            return ResponseEntity.badRequest().build();
        }

        // create a new product and map fields from request
        Product product = new Product();
        mapRequestToProduct(request, product, productCategory);

        return ResponseEntity.status(201).body(productRepository.save(product));
    }

    // update an existing product
    @PutMapping("/{id}")
    public ResponseEntity<Product> update(@PathVariable Long id, @RequestBody ProductRequest request) {
        // check if the product exists
        Optional<Product> result = productRepository.findById(id);

        if (result.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        // find the category by id
        ProductCategory productCategory = productCategoryRepository.findById(request.getCategoryId()).orElse(null);

        if (productCategory == null) {
            return ResponseEntity.badRequest().build();
        }

        // update the exisiting product with fields from request
        Product product = result.get();
        mapRequestToProduct(request, product, productCategory);

        return ResponseEntity.ok(productRepository.save(product));
    }

    // delete a product
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        if (!productRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }

        productRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }

    // helper method to map fields from DTO to entity
    private void mapRequestToProduct(ProductRequest request, Product product, ProductCategory productCategory) {
        product.setSku(request.getSku());
        product.setName(request.getName());
        product.setDescription(request.getDescription());
        product.setUnitPrice(request.getUnitPrice());
        product.setImageUrl(request.getImageUrl());
        product.setActive(request.isActive());
        product.setUnitsInStock(request.getUnitsInStock());

        product.setCategory(productCategory);
    }
}
