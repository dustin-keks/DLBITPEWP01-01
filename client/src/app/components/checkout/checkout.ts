import { CurrencyPipe } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { CheckoutFormService } from '../../services/checkout-form-service';
import { Country } from '../../common/country';
import { State } from '../../common/state';
import { CheckoutValidators } from '../../validators/checkout-validators';
import { CartService } from '../../services/cart-service';
import { CheckoutService } from '../../services/checkout-service';
import { Order } from '../../common/order';
import { OrderItem } from '../../common/order-item';
import { Purchase } from '../../common/purchase';
import { Router, RouterLink } from '@angular/router';
import { AuthService } from '../../services/auth-service';

@Component({
  selector: 'app-checkout',
  imports: [ReactiveFormsModule, CurrencyPipe, RouterLink],
  templateUrl: './checkout.html',
  styleUrl: './checkout.css',
})
export class Checkout implements OnInit {
  checkoutFormGroup!: FormGroup;

  totalPrice: number = 0;
  totalQuantity: number = 0;

  creditCardYears: number[] = [];
  creditCardMonths: number[] = [];

  countries: Country[] = [];
  
  billingAddressStates: State[] = [];
  shippingAddressStates: State[] = [];

  isLoggedIn: boolean = false;
  userEmail: string = '';

  constructor(private formBuilder: FormBuilder,
              private checkoutFormService: CheckoutFormService,
              private cartService: CartService,
              private checkoutService: CheckoutService,
              private router: Router,
              private authService: AuthService
  ) {}

  ngOnInit(): void {
    this.reviewCartDetails();

    this.checkoutFormGroup = this.formBuilder.group({
      customer: this.formBuilder.group({
        firstName: new FormControl('', [Validators.required, Validators.minLength(2), CheckoutValidators.notOnlyWhitespace]),
        lastName: new FormControl('', [Validators.required, Validators.minLength(2), CheckoutValidators.notOnlyWhitespace]),
        email: new FormControl('', [Validators.required, Validators.email])
      }),
      billingAddress: this.formBuilder.group({
        street: new FormControl('', [Validators.required, Validators.minLength(2), CheckoutValidators.notOnlyWhitespace]),
        zipCode: new FormControl('', [Validators.required, Validators.pattern('[0-9]{4,5}')]),
        city: new FormControl('', [Validators.required, Validators.minLength(2), CheckoutValidators.notOnlyWhitespace]),
        country: new FormControl('', [Validators.required]),
        state: new FormControl('', [Validators.required])
      }),
      shippingAddress: this.formBuilder.group({
        street: new FormControl('', [Validators.required, Validators.minLength(2), CheckoutValidators.notOnlyWhitespace]),
        zipCode: new FormControl('', [Validators.required, Validators.pattern('[0-9]{4,5}')]),
        city: new FormControl('', [Validators.required, Validators.minLength(2), CheckoutValidators.notOnlyWhitespace]),
        country: new FormControl('', [Validators.required]),
        state: new FormControl('', [Validators.required])
      }),
      creditCard: this.formBuilder.group({
        cardType: new FormControl('', [Validators.required]),
        nameOnCard: new FormControl('', [Validators.required, Validators.minLength(2), CheckoutValidators.notOnlyWhitespace]),
        cardNumber: new FormControl('', [Validators.required, Validators.pattern('[0-9]{16}')]),
        securityCode: new FormControl('', [Validators.required, Validators.pattern('[0-9]{3}')]),
        expirationMonth: [''],
        expirationYear: ['']
      })
    });

    // check login status and user email address
    this.authService.isLoggedIn().subscribe(data => {
      this.isLoggedIn = data;
    });

    this.authService.getUserEmail().subscribe(data => {
      this.userEmail = data;
      // set email so validation recognizes the value on submit (email field is disabled)
      this.checkoutFormGroup.get('customer.email')?.setValue(data);
    });

    // populate credit card months
    const startMonth: number = new Date().getMonth() + 1; // months are 0-based
    // console.log('startMonth: ' + startMonth);

    this.checkoutFormService.getCreditCardMonths(startMonth).subscribe(
      data => {
        // console.log('Retrieved credit card months ' + JSON.stringify(data));
        this.creditCardMonths = data;
        this.checkoutFormGroup.get('creditCard')!.get('expirationMonth')!.setValue(data[0]);
      }
    );

    // populate credit card years
    this.checkoutFormService.getCreditCardYears().subscribe(
      data => {
        // console.log('Retrieved credit card years ' + JSON.stringify(data));
        this.creditCardYears = data;
        this.checkoutFormGroup.get('creditCard')!.get('expirationYear')!.setValue(data[0]);
      }
    );

    // populate countries
    this.checkoutFormService.getCountries().subscribe(
      data => {
        // console.log('Retrieved countries: ' + JSON.stringify(data));
        this.countries = data;
      }
    );
  }

  reviewCartDetails() {
    // subscibe to cartService.totalQuantity
    this.cartService.totalQuantity.subscribe(
      totalQuantity => this.totalQuantity = totalQuantity
    );

    // subscribe to cartService.totalPrice
    this.cartService.totalPrice.subscribe(
      totalPrice => this.totalPrice = totalPrice
    );
  }

  // getter methods to access form controls
  // - customer
  get firstName() {
    return this.checkoutFormGroup.get('customer.firstName');
  }
  get lastName() {
    return this.checkoutFormGroup.get('customer.lastName');
  }
  get email() {
    return this.checkoutFormGroup.get('customer.email');
  }

  // - billingAddress
  get billingAddressStreet() {
    return this.checkoutFormGroup.get('billingAddress.street');
  }
  get billingAddressZipCode() {
    return this.checkoutFormGroup.get('billingAddress.zipCode');
  }
  get billingAddressCity() {
    return this.checkoutFormGroup.get('billingAddress.city');
  }
  get billingAddressCountry() {
    return this.checkoutFormGroup.get('billingAddress.country');
  }
  get billingAddressState() {
    return this.checkoutFormGroup.get('billingAddress.state');
  }

  // - shippingAddress
  get shippingAddressStreet() {
    return this.checkoutFormGroup.get('shippingAddress.street');
  }
  get shippingAddressZipCode() {
    return this.checkoutFormGroup.get('shippingAddress.zipCode');
  }
  get shippingAddressCity() {
    return this.checkoutFormGroup.get('shippingAddress.city');
  }
  get shippingAddressCountry() {
    return this.checkoutFormGroup.get('shippingAddress.country');
  }
  get shippingAddressState() {
    return this.checkoutFormGroup.get('shippingAddress.state');
  }

  // - creditCard
  get creditCardCardType() {
    return this.checkoutFormGroup.get('creditCard.cardType');
  }
  get creditCardNameOnCard() {
    return this.checkoutFormGroup.get('creditCard.nameOnCard');
  }
  get creditCardCardNumber() {
    return this.checkoutFormGroup.get('creditCard.cardNumber');
  }
  get creditCardSecurityCode() {
    return this.checkoutFormGroup.get('creditCard.securityCode');
  }

  onSubmit() {
    // console.log('Handling the submit button');

    if (this.checkoutFormGroup.invalid) {
      this.checkoutFormGroup.markAllAsTouched();
      return;
    }

    // set up order
    let order = new Order();
    order.totalPrice = this.totalPrice;
    order.totalQuantity = this.totalQuantity;

    // get cart items
    const cartItems = this.cartService.cartItems;

    // create orderItems from cartItems
    let orderItems: OrderItem[] = [];
    for (let i = 0; i < cartItems.length; i++) {
      orderItems[i] = new OrderItem(cartItems[i]);
    }

    // set up purchase
    let purchase = new Purchase();

    // populate purchase - customer
    purchase.customer = this.checkoutFormGroup.controls['customer'].value;
    // Manually set the email from the auth service because the email field is disabled in the form,
    // and Angular excludes disabled controls from the form value on submit.
    purchase.customer.email = this.userEmail;

    // populate purchase - billing address
    purchase.billingAddress = this.checkoutFormGroup.controls['billingAddress'].value;
    const billingCountry: Country = JSON.parse(JSON.stringify(purchase.billingAddress.country));
    const billingState: State = JSON.parse(JSON.stringify(purchase.billingAddress.state));
    purchase.billingAddress.country = billingCountry.name;
    purchase.billingAddress.state = billingState.name;

    // populate purchase - shipping address
    purchase.shippingAddress = this.checkoutFormGroup.controls['shippingAddress'].value;
    const shippingCountry: Country = JSON.parse(JSON.stringify(purchase.shippingAddress.country));
    const shippingState: State = JSON.parse(JSON.stringify(purchase.shippingAddress.state));
    purchase.shippingAddress.country = shippingCountry.name;
    purchase.shippingAddress.state = shippingState.name;

    // populate purchase - order and orderItems
    purchase.order = order;
    purchase.orderItems = orderItems;

    // call REST API via the CheckoutService
    this.checkoutService.placeOrder(purchase).subscribe(
      {
        next: response => {
          alert(`Deine Bestellung war erfolgreich!\nBestellverfolgungsnummer: ${response.orderTrackingNumber}`);

          // reset cart
          this.resetCart();
        },
        error: err => {
          alert(`{Ein Fehler ist aufgetreten: ${err.message}`);
        }
      }
    );
  }

  resetCart() {
    // reset cart data
    this.cartService.cartItems = [];
    this.cartService.totalPrice.next(0);
    this.cartService.totalQuantity.next(0);

    // reset form data
    this.checkoutFormGroup.reset();

    // navigate back to home page
    this.router.navigateByUrl('/')
  }

  handleMonthsAndYears() {
    const creditCardFormGroup = this.checkoutFormGroup.get('creditCard');

    const currentYear: number = new Date().getFullYear();
    const selectedYear: number = Number(creditCardFormGroup?.value.expirationYear);

    // if the current year equals the selected year, then start with the current month
    let startMonth: number;

    if (currentYear === selectedYear) {
      startMonth = new Date().getMonth() + 1; // months are 0-based
    } else {
      startMonth = 1;
    }

    this.checkoutFormService.getCreditCardMonths(startMonth).subscribe(
      data => {
        // console.log('Retrieved credit card months: ' + JSON.stringify(data));
        this.creditCardMonths = data;
      }
    );
  }

  getStates(formGroupName: string) {
    const formGroup = this.checkoutFormGroup.get(formGroupName);

    const countryCode = formGroup!.value.country.code;
    const countryName = formGroup!.value.country.name;

    // console.log(`${formGroupName} country code: ${countryCode}`);
    // console.log(`${formGroupName} country name: ${countryName}`);

    this.checkoutFormService.getStates(countryCode).subscribe(
      data => {
        if (formGroupName === 'billingAddress') {
          this.billingAddressStates = data;
        } else {
          this.shippingAddressStates = data;
        }

        // select first item by default
        formGroup!.get('state')!.setValue(data[0]);
      }
    )
  }
}
