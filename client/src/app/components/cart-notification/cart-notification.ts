import { Component, OnInit } from '@angular/core';
import { CartService } from '../../services/cart-service';
import { NgbToast } from '@ng-bootstrap/ng-bootstrap';

@Component({
  selector: 'app-cart-notification',
  imports: [NgbToast],
  templateUrl: './cart-notification.html',
  styleUrl: './cart-notification.css',
})
export class CartNotification implements OnInit {
  message: string = '';
  visible: boolean = false;

  constructor(private cartService: CartService) {}

  ngOnInit(): void {
    this.cartService.lastAddedProductName.subscribe(name => {
      this.message = name;
      this.visible = true;
    });
  }

  hide(): void {
    this.visible = false;
  }
}
