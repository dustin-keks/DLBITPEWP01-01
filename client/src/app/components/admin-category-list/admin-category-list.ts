import { Component, OnInit } from '@angular/core';
import { ProductCategory } from '../../common/product-category';
import { AdminService } from '../../services/admin-service';
import { RouterLink } from "@angular/router";

@Component({
  selector: 'app-admin-category-list',
  imports: [RouterLink],
  templateUrl: './admin-category-list.html',
  styleUrl: './admin-category-list.css',
})
export class AdminCategoryList implements OnInit {
  categories: ProductCategory[] = [];

  constructor(private adminService: AdminService) {}

  ngOnInit(): void {
    this.loadCategories();
  }

  loadCategories() {
    this.adminService.getCategories().subscribe(data => {
      this.categories = data;
    });
  }

  deleteCategory(id: number) {
    if (confirm('Möchtest du die Kategorie wirklich löschen?')) {
      this.adminService.deleteCategory(id).subscribe(() => {
        // re-load list after deleting the category
        this.loadCategories();
      })
    }
  }
}
