import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { AuthService } from '../../services/auth-service';
import { AsyncPipe } from '@angular/common';
import { RouterLink } from "@angular/router";

@Component({
  selector: 'app-admin-banner',
  imports: [AsyncPipe, RouterLink],
  templateUrl: './admin-banner.html',
  styleUrl: './admin-banner.css',
})
export class AdminBanner implements OnInit {
  userRole!: Observable<string>;

  constructor(private authService: AuthService) {}

  ngOnInit(): void {
    this.userRole = this.authService.getRole();
  }
}
