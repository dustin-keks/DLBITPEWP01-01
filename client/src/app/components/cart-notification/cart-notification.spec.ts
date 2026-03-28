import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CartNotification } from './cart-notification';

describe('CartNotification', () => {
  let component: CartNotification;
  let fixture: ComponentFixture<CartNotification>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CartNotification]
    })
    .compileComponents();

    fixture = TestBed.createComponent(CartNotification);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
