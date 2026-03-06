import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { AuthService } from '../../services/auth-service';
import { RouterLink } from '@angular/router';
import { AsyncPipe } from '@angular/common';

@Component({
  selector: 'app-login-status',
  imports: [AsyncPipe, RouterLink],
  templateUrl: './login-status.html',
  styleUrl: './login-status.css',
})
export class LoginStatus implements OnInit {
  isLoggedIn!: Observable<boolean>;

  constructor(private authService: AuthService) {}

  ngOnInit(): void {
    this.isLoggedIn = this.authService.isLoggedIn();
  }
}
