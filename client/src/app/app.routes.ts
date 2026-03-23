import { Routes } from '@angular/router';
import { ProductList } from './components/product-list/product-list';
import { ProductDetails } from './components/product-details/product-details';
import { CartDetails } from './components/cart-details/cart-details';
import { Checkout } from './components/checkout/checkout';
import { Login } from './components/login/login';
import { Register } from './components/register/register';
import { AdminCategoryList } from './components/admin-category-list/admin-category-list';
import { adminGuard } from './guards/admin-guard';
import { AdminCategoryForm } from './components/admin-category-form/admin-category-form';
import { AdminProductForm } from './components/admin-product-form/admin-product-form';
import { AdminProductList } from './components/admin-product-list/admin-product-list';

export const routes: Routes = [
    {path: 'admin/products/edit/:id', component: AdminProductForm, canActivate: [adminGuard]},
    {path: 'admin/products/new', component: AdminProductForm, canActivate: [adminGuard]},
    {path: 'admin/products', component: AdminProductList, canActivate: [adminGuard]},
    {path: 'admin/categories/edit/:id', component: AdminCategoryForm, canActivate: [adminGuard]},
    {path: 'admin/categories/new', component: AdminCategoryForm, canActivate: [adminGuard]},
    {path: 'admin/categories', component: AdminCategoryList, canActivate: [adminGuard]},
    {path: 'register', component: Register},
    {path: 'login', component: Login},
    {path: 'checkout', component: Checkout},
    {path: 'cart-details', component: CartDetails},
    {path: 'products/:id', component: ProductDetails},
    {path: 'search/:keyword', component: ProductList},
    {path: 'category/:id', component: ProductList},
    {path: 'category', component: ProductList},
    {path: 'products', component: ProductList},
    {path: '', redirectTo: '/products', pathMatch: 'full'},
    {path: '**', redirectTo: '/products', pathMatch: 'full'}
];
