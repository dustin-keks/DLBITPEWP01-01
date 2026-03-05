package com.example.ecommerce.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;

@RestController
@RequestMapping("/api/auth")
public class AuthController {
    @GetMapping("/status")
    public ResponseEntity<?> getStatus() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();

        Map<String, Object> response = new HashMap<>();

        if (auth != null && auth.isAuthenticated() && !auth.getName().equals("anonymousUser")) {
            response.put("loggedIn", true);
            response.put("email", auth.getName());
        } else {
            response.put("loggedIn", false);
        }

        return ResponseEntity.ok(response);
    }
}
