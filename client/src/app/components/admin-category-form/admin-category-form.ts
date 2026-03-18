import { Component, OnInit } from '@angular/core';
import { ProductCategory } from '../../common/product-category';
import { AdminService } from '../../services/admin-service';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { FormsModule } from "@angular/forms";

@Component({
  selector: 'app-admin-category-form',
  imports: [FormsModule, RouterLink],
  templateUrl: './admin-category-form.html',
  styleUrl: './admin-category-form.css',
})
export class AdminCategoryForm implements OnInit {
  category: ProductCategory = new ProductCategory(0, '');
  isEditMode: boolean = false;

  constructor(
    private adminService: AdminService, 
    private route: ActivatedRoute, 
    private router: Router
  ) {}

  ngOnInit(): void {
    // check if URL contains id
    const id = this.route.snapshot.paramMap.get('id');

    if (id) {
      // enable edit mode
      this.isEditMode = true;

      // load category data from backend
      this.adminService.getCategory(+id).subscribe(data => {
        this.category = data;
      })
    }
  }

  onSubmit() {
    if (this.isEditMode) {
      // update category - PUT request
      this.adminService.updateCategory(this.category.id, this.category).subscribe(() => {
        this.router.navigateByUrl('/admin/categories')
      })
    } else {
      // create category - POST request
      this.adminService.createCategory(this.category).subscribe(() => {
        this.router.navigateByUrl('/admin/categories');
      })
    }
  }
}
