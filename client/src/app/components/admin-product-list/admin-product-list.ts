import { Component, OnInit } from '@angular/core';
import { AdminService } from '../../services/admin-service';
import { Product } from '../../common/product';
import { CurrencyPipe } from '@angular/common';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-admin-product-list',
  imports: [CurrencyPipe, RouterLink],
  templateUrl: './admin-product-list.html',
  styleUrl: './admin-product-list.css',
})
export class AdminProductList implements OnInit {
  products: Product[] = [];

  constructor(private adminService: AdminService) {}
  
  ngOnInit(): void {
    this.loadProducts();
  }

  loadProducts() {
    this.adminService.getProducts().subscribe(data => {
      this.products = data;
    });
  }

  deleteProduct(id: number) {
    if (confirm('Möchtest du das Produkt wirklich löschen?')) {
      this.adminService.deleteProduct(id).subscribe(() => {
        // re-load list after deleting the product
        this.loadProducts();
      })
    }
  }
}
