import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { CheckoutValidators } from '../../validators/checkout-validators';

@Component({
  selector: 'app-register',
  imports: [ReactiveFormsModule, RouterLink],
  templateUrl: './register.html',
  styleUrl: './register.css',
})
export class Register implements OnInit {
  registerForm!: FormGroup;
  successMessage = '';
  errorMessage = '';

  constructor(private http: HttpClient, private router: Router, private formBuilder: FormBuilder) {}

  ngOnInit(): void {
    this.registerForm = this.formBuilder.group({
      firstName: new FormControl('', [Validators.required, Validators.minLength(2), CheckoutValidators.notOnlyWhitespace]),
      lastName: new FormControl('', [Validators.required, Validators.minLength(2), CheckoutValidators.notOnlyWhitespace]),
      email: new FormControl('', [Validators.required, Validators.email]),
      password: new FormControl('', [Validators.required, Validators.minLength(8), CheckoutValidators.notOnlyWhitespace])
    })
  }

  // getter methods
  get firstName() {
    return this.registerForm.get('firstName');
  }
  get lastName() {
    return this.registerForm.get('lastName');
  }
  get email() {
    return this.registerForm.get('email');
  }
  get password() {
    return this.registerForm.get('password');
  }

  onSubmit(): void {
    if (this.registerForm.invalid) {
      this.registerForm.markAllAsTouched();
      return;
    }

    this.successMessage = '';
    this.errorMessage = '';

    this.http.post('http://localhost:8080/api/auth/register', {
      firstName: this.firstName?.value,
      lastName: this.lastName?.value,
      email: this.email?.value,
      password: this.password?.value
    }).subscribe({
      next: () => {
        this.registerForm.reset();
        this.successMessage = 'Registrierung erfolgreich, du kannst dich jetzt einloggen!'
      },
      error: (err) => {
        if (err.status === 409) {
          this.errorMessage = 'Diese E-Mail-Adresse ist bereits vergeben';
        } else {
          this.errorMessage = 'Registrierung fehlgeschlagen'
        }
      }
    })
  }
}
