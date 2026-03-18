import { Component, signal } from '@angular/core';
import { RouterOutlet, RouterLink } from '@angular/router';
import { ProductCategoryMenu } from './components/product-category-menu/product-category-menu';
import { Search } from './components/search/search';
import { CartStatus } from './components/cart-status/cart-status';
import { LoginStatus } from './components/login-status/login-status';
import { AdminBanner } from './components/admin-banner/admin-banner';

@Component({
  selector: 'app-root',
  imports: [RouterOutlet, RouterLink, ProductCategoryMenu, Search, CartStatus, LoginStatus, AdminBanner],
  templateUrl: './app.html',
  styleUrl: './app.css'
})
export class App {
  protected readonly title = signal('client');
}
