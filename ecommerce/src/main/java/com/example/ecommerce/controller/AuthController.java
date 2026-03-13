package com.example.ecommerce.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.ecommerce.dao.CustomerRepository;
import com.example.ecommerce.entity.Customer;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@RestController
@RequestMapping("/api/auth")
public class AuthController {
    private final CustomerRepository customerRepository;
    private final BCryptPasswordEncoder passwordEncoder;

    public AuthController(CustomerRepository customerRepository, BCryptPasswordEncoder passwordEncoder) {
        this.customerRepository = customerRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody Map<String, String> body) {
        // check if email address already exists
        Map<String, String> response = new HashMap<>();

        if (customerRepository.findByEmail(body.get("email")) != null) {
            response.put("message", "E-Mail-Adresse ist bereits vergeben");
            return ResponseEntity.status(409).body(response);
        }

        // create new customer and save it
        Customer customer = new Customer();
        customer.setFirstName(body.get("firstName"));
        customer.setLastName(body.get("lastName"));
        customer.setEmail(body.get("email"));
        customer.setPassword(passwordEncoder.encode(body.get("password")));
        customer.setRole("ROLE_USER");

        customerRepository.save(customer);

        response.put("message", "Registrierung erfolgreich");
        return ResponseEntity.status(201).body(response);
    }

    @GetMapping("/status")
    public ResponseEntity<?> getStatus() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();

        Map<String, Object> response = new HashMap<>();

        if (auth != null && auth.isAuthenticated() && !auth.getName().equals("anonymousUser")) {
            response.put("loggedIn", true);
            response.put("email", auth.getName());

            Customer customer = customerRepository.findByEmail(auth.getName());
            if (customer != null) {
                response.put("role", customer.getRole());
            }
        } else {
            response.put("loggedIn", false);
        }

        return ResponseEntity.ok(response);
    }

    @PostMapping("/logout")
    public ResponseEntity<?> logout(HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();

        HttpSession session = request.getSession(false);

        if (session != null) {
            session.invalidate();
        }

        SecurityContextHolder.clearContext();

        response.put("loggedIn", false);

        return ResponseEntity.ok(response);
    }
}
