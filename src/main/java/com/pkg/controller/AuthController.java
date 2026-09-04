package com.pkg.controller;

import com.pkg.dto.LoginDTO;
import com.pkg.dto.UserDTO;
import com.pkg.dao.UserDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
public class AuthController {
    
    @Autowired
    private UserDAO userDAO;
    
    @GetMapping("/")
    public String home(HttpSession session, Model model) {
        if (session.getAttribute("userId") != null) {
            Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
            if (isAdmin != null && isAdmin) {
                return "redirect:/admin";
            }
            return "redirect:/dashboard";
        }
        return "index";  // ← WITHOUT .jsp
    }
    
    @GetMapping("/login")
    public String showLoginPage(HttpSession session, Model model) {
        if (session.getAttribute("userId") != null) {
            Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
            if (isAdmin != null && isAdmin) {
                return "redirect:/admin";
            }
            return "redirect:/dashboard";
        }
        model.addAttribute("loginDTO", new LoginDTO());
        return "login";  // ← WITHOUT .jsp
    }
    
    @PostMapping("/login")
    public String login(@ModelAttribute LoginDTO loginDTO, HttpSession session, Model model) {
        if (loginDTO.getEmail() == null || loginDTO.getEmail().trim().isEmpty()) {
            model.addAttribute("error", "Email is required");
            return "login";
        }
        if (loginDTO.getPassword() == null || loginDTO.getPassword().trim().isEmpty()) {
            model.addAttribute("error", "Password is required");
            return "login";
        }
        
        if (userDAO.validateUser(loginDTO.getEmail(), loginDTO.getPassword())) {
            UserDTO user = userDAO.findByEmail(loginDTO.getEmail());
            session.setAttribute("userId", user.getId());
            session.setAttribute("userName", user.getFullName());
            session.setAttribute("userEmail", user.getEmail());
            
            boolean isAdmin = user.getEmail().equals("admin@helphub.com");
            session.setAttribute("isAdmin", isAdmin);
            
            if (isAdmin) {
                return "redirect:/admin";
            } else {
                return "redirect:/dashboard";
            }
        } else {
            model.addAttribute("error", "Invalid email or password");
            return "login";
        }
    }
    
    @GetMapping("/register")
    public String showRegisterPage(HttpSession session, Model model) {
        if (session.getAttribute("userId") != null) {
            Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
            if (isAdmin != null && isAdmin) {
                return "redirect:/admin";
            }
            return "redirect:/dashboard";
        }
        model.addAttribute("userDTO", new UserDTO());
        return "register";  // ← WITHOUT .jsp
    }
    
    @PostMapping("/register")
    public String register(@ModelAttribute UserDTO userDTO, Model model) {
        if (userDTO.getFirstName() == null || userDTO.getFirstName().trim().isEmpty()) {
            model.addAttribute("error", "First name is required");
            return "register";
        }
        if (userDTO.getLastName() == null || userDTO.getLastName().trim().isEmpty()) {
            model.addAttribute("error", "Last name is required");
            return "register";
        }
        if (userDTO.getEmail() == null || userDTO.getEmail().trim().isEmpty()) {
            model.addAttribute("error", "Email is required");
            return "register";
        }
        if (userDTO.getPassword() == null || userDTO.getPassword().trim().isEmpty()) {
            model.addAttribute("error", "Password is required");
            return "register";
        }
        if (userDTO.getPassword().length() < 6) {
            model.addAttribute("error", "Password must be at least 6 characters");
            return "register";
        }
        if (userDTO.getPhone() == null || userDTO.getPhone().trim().isEmpty()) {
            model.addAttribute("error", "Phone number is required");
            return "register";
        }
        if (userDTO.getCity() == null || userDTO.getCity().trim().isEmpty()) {
            model.addAttribute("error", "City is required");
            return "register";
        }
        
        if (userDAO.findByEmail(userDTO.getEmail()) != null) {
            model.addAttribute("error", "Email already registered");
            return "register";
        }
        
        if (userDAO.register(userDTO)) {
            model.addAttribute("success", "Registration successful! Please login.");
            return "login";
        } else {
            model.addAttribute("error", "Registration failed. Please try again.");
            return "register";
        }
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login?logout=true";
    }
}