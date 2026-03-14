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
import com.example.ecommerce.entity.ProductCategory;

@RestController
@RequestMapping("/api/admin/categories")
public class AdminCategoryController {
    private final ProductCategoryRepository categoryRepository;

    public AdminCategoryController(ProductCategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    // return all categories
    @GetMapping
    public List<ProductCategory> getAll() {
        return categoryRepository.findAll();
    }

    // return a single category
    @GetMapping("/{id}")
    public ResponseEntity<ProductCategory> getById(@PathVariable Long id) {
        Optional<ProductCategory> result = categoryRepository.findById(id);

        if (result.isPresent()) {
            return ResponseEntity.ok(result.get());
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    // create a new category
    @PostMapping
    public ProductCategory create(@RequestBody ProductCategory category) {
        // JPA generates id (auto_increment)
        category.setId(null);
        return categoryRepository.save(category);
    }

    // update an existing category
    @PutMapping("/{id}")
    public ResponseEntity<ProductCategory> update(@PathVariable Long id, @RequestBody ProductCategory category) {
        if (!categoryRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }

        category.setId(id);
        return ResponseEntity.ok(categoryRepository.save(category));
    }

    // delete a category
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        if (!categoryRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }

        categoryRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
