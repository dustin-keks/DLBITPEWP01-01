import { CanActivateFn, Router } from '@angular/router';
import { AuthService } from '../services/auth-service';
import { inject } from '@angular/core';
import { firstValueFrom } from 'rxjs';

export const adminGuard: CanActivateFn = async (route, state) => {
  const authService = inject(AuthService);
  const router = inject(Router);

  // current user role
  const role = await firstValueFrom(authService.fetchRole());

  if (role === 'ROLE_ADMIN') {
    return true;
  } else {
    router.navigateByUrl('/login');
    return false;
  }
};
