import { NgModule, provideBrowserGlobalErrorListeners } from '@angular/core';
import { BrowserModule, provideClientHydration, withEventReplay, withHttpTransferCacheOptions } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing-module';
import { App } from './app';
import { ProductList } from './components/product-list/product-list';
import { provideHttpClient, withFetch, withInterceptorsFromDi } from '@angular/common/http';
import { ProductService } from './services/product-service';
import { RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  {path: 'category/:id', component: ProductList},
  {path: 'category', component: ProductList},
  {path: 'products', component: ProductList},
  {path: '', redirectTo: '/products', pathMatch: 'full'},
  {path: '**', redirectTo: '/products', pathMatch: 'full'}
];

@NgModule({
  declarations: [
    App,
    ProductList
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    RouterModule.forRoot(routes)
  ],
  providers: [
    provideBrowserGlobalErrorListeners(),
    provideClientHydration(withEventReplay(), withHttpTransferCacheOptions({})),
    provideHttpClient(withInterceptorsFromDi(), withFetch()),
    ProductService
  ],
  bootstrap: [App]
})
export class AppModule { }
