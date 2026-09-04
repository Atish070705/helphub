package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling 
@ComponentScan(basePackages = "com.pkg")
public class HelphubApplication {

	public static void main(String[] args) {
		SpringApplication.run(HelphubApplication.class, args);
	}

}
