import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BehaviorSubject, map, Observable, tap } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  private apiUrl = 'http://localhost:8080/api/auth';
  private loggedIn = new BehaviorSubject<boolean>(false);
  private userEmail = new BehaviorSubject<string>('');
  private userRole = new BehaviorSubject<string>('');

  constructor(private http: HttpClient) {
    this.checkStatus();
  }

  checkStatus() {
    this.http.get<AuthStatus>(`${this.apiUrl}/status`).subscribe(status => {
      this.loggedIn.next(status.loggedIn);
      this.userEmail.next(status.email ?? '');
      this.userRole.next(status.role ?? '');
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
      this.userRole.next('');
    }));
  }

  isLoggedIn(): Observable<boolean> {
    return this.loggedIn.asObservable();
  }

  getUserEmail(): Observable<string> {
    return this.userEmail.asObservable();
  }

  getRole(): Observable<string> {
    return this.userRole.asObservable();
  }

  // fetch role from backend (used for guard)
  fetchRole(): Observable<string> {
    return this.http.get<AuthStatus>(`${this.apiUrl}/status`).pipe(
      map(status => status.role ?? '')
    );
  }
}

interface AuthStatus {
  loggedIn: boolean;
  email?: string;
  role?: string;
}