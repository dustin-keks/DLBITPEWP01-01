package com.example.ecommerce.dto;

import java.math.BigDecimal;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductRequest {
    private String sku;
    private String name;
    private String description;
    private BigDecimal unitPrice;
    private BigDecimal salePrice;
    private String imageUrl;
    private boolean active;
    private int unitsInStock;
    private Long categoryId;
}
