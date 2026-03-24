import { Component, OnInit } from '@angular/core';
import { ProductCategory } from '../../common/product-category';
import { AdminService } from '../../services/admin-service';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-admin-product-form',
  imports: [FormsModule, RouterLink],
  templateUrl: './admin-product-form.html',
  styleUrl: './admin-product-form.css',
})
export class AdminProductForm implements OnInit {
  // form data ... matches the ProductRequest structure in the backend
  product = {
    sku: '',
    name: '',
    description: '',
    unitPrice: 0,
    salePrice: 0,
    imageUrl: '',
    active: true,
    unitsInStock: 0,
    categoryId: 0
  }

  // categories for the dropdown list
  categories: ProductCategory[] = [];

  isEditMode = false;
  productId = 0;

  constructor(
    private adminService: AdminService,
    private route: ActivatedRoute,
    private router: Router
  ) {}

  ngOnInit(): void {
    // load all categories for the dropdown list
    this.adminService.getCategories().subscribe(data => {
      this.categories = data;

      if (!this.isEditMode && data.length > 0) {
        this.product.categoryId = data[0].id;
      }
    });

    // check if URL contains ID for edit mode
    const id = this.route.snapshot.paramMap.get('id');

    if (id) {
      this.isEditMode = true;
      this.productId = +id;

      // load product data and map to form object
      this.adminService.getProduct(this.productId).subscribe((data: any) => {
        this.product = {
          sku: data.sku,
          name: data.name,
          description: data.description,
          unitPrice: data.unitPrice,
          salePrice: data.salePrice ?? 0,
          imageUrl: data.imageUrl,
          active: data.active,
          unitsInStock: data.unitsInStock,
          categoryId: data.category.id ?? 0
        }
      })
    }
  }

  onSubmit() {
    if (this.isEditMode) {
      // update product
      this.adminService.updateProduct(this.productId, this.product).subscribe(() => {
        this.router.navigateByUrl('/admin/products');
      })
    } else {
      // create product
      this.adminService.createProduct(this.product).subscribe(() => {
        this.router.navigateByUrl('/admin/products');
      })
    }
  }
}
