import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../services/auth-service';
import { Router, RouterLink } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { Observable } from 'rxjs';
import { AsyncPipe } from '@angular/common';

@Component({
  selector: 'app-login',
  imports: [FormsModule, AsyncPipe, RouterLink],
  templateUrl: './login.html',
  styleUrl: './login.css',
})
export class Login implements OnInit {
  email = '';
  password = '';
  successMessage = '';
  errorMessage = '';

  isLoggedIn!: Observable<boolean>;
  userEmail!: Observable<string>;

  constructor(private authService: AuthService, private router: Router) {}

  ngOnInit(): void {
    this.isLoggedIn = this.authService.isLoggedIn();
    this.userEmail = this.authService.getUserEmail();
  }

  onSubmit(): void {
    this.errorMessage = '';
    this.authService.login(this.email, this.password).subscribe({
      next: () => this.successMessage = 'Login erfolgreich!',
      error: () => this.errorMessage = 'Die E-Mail-Adresse oder das Passwort sind falsch'
    });
  }

  logout(): void {
    this.authService.logout().subscribe(() => {
      this.successMessage = 'Du wurdest erfolgreich ausgeloggt';
    });
  }
}
