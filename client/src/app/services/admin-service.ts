import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { ProductCategory } from '../common/product-category';
import { Product } from '../common/product';

@Injectable({
  providedIn: 'root',
})
export class AdminService {
  private categoryUrl = 'http://localhost:8080/api/admin/categories';
  private productUrl = 'http://localhost:8080/api/admin/products';

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
  getProducts(): Observable<Product[]> {
    return this.http.get<Product[]>(this.productUrl);
  }

  getProduct(id: number): Observable<Product> {
    return this.http.get<Product>(`${this.productUrl}/${id}`);
  }

  createProduct(product: ProductRequest): Observable<Product> {
    return this.http.post<Product>(this.productUrl, product);
  }

  updateProduct(id: number, product: ProductRequest): Observable<Product> {
    return this.http.put<Product>(`${this.productUrl}/${id}`, product);
  }

  deleteProduct(id: number): Observable<void> {
    return this.http.delete<void>(`${this.productUrl}/${id}`)
  }
}

// DTO interface for creating/updating products
interface ProductRequest {
  sku: string;
  name: string;
  description: string;
  unitPrice: number;
  imageUrl: string;
  active: boolean;
  unitsInStock: number

  categoryId: number;
}