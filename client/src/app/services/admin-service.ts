import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { ProductCategory } from '../common/product-category';

@Injectable({
  providedIn: 'root',
})
export class AdminService {
  private categoryUrl = 'http://localhost:8080/api/admin/categories';

  constructor(private http: HttpClient) {}

  // categories
  getCategories(): Observable<ProductCategory[]> {
    return this.http.get<ProductCategory[]>(this.categoryUrl);
  }

  getCategory(id: number): Observable<ProductCategory> {
    return this.http.get<ProductCategory>(`${this.categoryUrl}/${id}`);
  }

  createCategory(category: ProductCategory): Observable<ProductCategory> {
    return this.http.post<ProductCategory>(this.categoryUrl, category);
  }

  updateCategory(id: number, category: ProductCategory): Observable<ProductCategory> {
    return this.http.put<ProductCategory>(`${this.categoryUrl}/${id}`, category);
  }

  deleteCategory(id: number): Observable<void> {
    return this.http.delete<void>(`${this.categoryUrl}/${id}`);
  }

  // products
}
