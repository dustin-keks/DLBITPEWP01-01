import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable, tap } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  private apiUrl = 'http://localhost:8080/api/auth';
  private loggedIn = new BehaviorSubject<boolean>(false);
  private userEmail = new BehaviorSubject<string>('');

  constructor(private http: HttpClient) {
    this.checkStatus();
  }

  checkStatus() {
    this.http.get<AuthStatus>(`${this.apiUrl}/status`).subscribe(status => {
      this.loggedIn.next(status.loggedIn);
      this.userEmail.next(status.email ?? '');
    });
  }

  login(email: string, password: string): Observable<any> {
    const body = new URLSearchParams();

    body.set('email', email);
    body.set('password', password);

    return this.http.post(`${this.apiUrl}/login`, body.toString(), {
      headers: {'Content-Type': 'application/x-www-form-urlencoded'}
    }).pipe(tap(() => this.checkStatus()));
  }

  logout(): Observable<any> {
    return this.http.post(`${this.apiUrl}/logout`, {}).pipe(tap(() => {
      this.loggedIn.next(false);
      this.userEmail.next('');
    }));
  }

  isLoggedIn(): Observable<boolean> {
    return this.loggedIn.asObservable();
  }

  getUserEmail(): Observable<string> {
    return this.userEmail.asObservable();
  }
}

interface AuthStatus {
  loggedIn: boolean;
  email?: string;
}