import { NgModule, provideBrowserGlobalErrorListeners } from '@angular/core';
import { BrowserModule, provideClientHydration, withEventReplay, withHttpTransferCacheOptions } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing-module';
import { App } from './app';
import { ProductList } from './components/product-list/product-list';
import { provideHttpClient, withFetch, withInterceptorsFromDi } from '@angular/common/http';
import { ProductService } from './services/product-service';

@NgModule({
  declarations: [
    App,
    ProductList
  ],
  imports: [
    BrowserModule,
    AppRoutingModule
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
