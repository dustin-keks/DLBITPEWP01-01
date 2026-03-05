package com.example.ecommerce.config;

import java.util.Arrays;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class MyAppConfig implements WebMvcConfigurer {
    @Value("${allowed.origins}")
    private String[] theAllowedOrigins;

    @Value("${allowed.methods}")
    private String[] theAllowedMethods;

    @Value("${spring.data.rest.base-path}")
    private String basePath;

    // Spring MVC (Spring Data REST)
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        // set up cors mapping
        registry.addMapping(basePath + "/**")
                .allowedOrigins(theAllowedOrigins)
                .allowedMethods(theAllowedMethods)
                .allowedHeaders("*")
                .allowCredentials(true);
    }

    // Spring Security
    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration config = new CorsConfiguration();

        config.setAllowedOrigins(Arrays.asList(theAllowedOrigins));
        config.setAllowedMethods(Arrays.asList(theAllowedMethods));
        config.addAllowedHeader("*");
        config.setAllowCredentials(true);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", config);

        return source;
    }
}
