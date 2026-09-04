package com.pkg.controller;

import com.pkg.dto.UserDTO;
import com.pkg.dao.UserDAO;
import com.pkg.dao.RequestDAO;
import com.pkg.dao.ResponseDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class UserController {
    
    @Autowired
    private UserDAO userDAO;
    
    @Autowired
    private RequestDAO requestDAO;
    
    @Autowired
    private ResponseDAO responseDAO;
    
    @GetMapping("/profile")
    public String viewProfile(HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        
        UserDTO user = userDAO.getUserWithStats((Long) session.getAttribute("userId"));
        model.addAttribute("user", user);
        return "profile";  // ← WITHOUT .jsp
    }
    
    @GetMapping("/profile/edit")
    public String showEditProfileForm(HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        
        UserDTO user = userDAO.findById((Long) session.getAttribute("userId"));
        model.addAttribute("user", user);
        return "profile";  // ← WITHOUT .jsp
    }
    
    @PostMapping("/profile/update")
    public String updateProfile(@ModelAttribute UserDTO userDTO, HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        
        if (userDTO.getFirstName() == null || userDTO.getFirstName().trim().isEmpty()) {
            model.addAttribute("error", "First name is required");
            UserDTO user = userDAO.getUserWithStats((Long) session.getAttribute("userId"));
            model.addAttribute("user", user);
            return "profile";
        }
        if (userDTO.getLastName() == null || userDTO.getLastName().trim().isEmpty()) {
            model.addAttribute("error", "Last name is required");
            UserDTO user = userDAO.getUserWithStats((Long) session.getAttribute("userId"));
            model.addAttribute("user", user);
            return "profile";
        }
        if (userDTO.getPhone() == null || userDTO.getPhone().trim().isEmpty()) {
            model.addAttribute("error", "Phone number is required");
            UserDTO user = userDAO.getUserWithStats((Long) session.getAttribute("userId"));
            model.addAttribute("user", user);
            return "profile";
        }
        if (userDTO.getCity() == null || userDTO.getCity().trim().isEmpty()) {
            model.addAttribute("error", "City is required");
            UserDTO user = userDAO.getUserWithStats((Long) session.getAttribute("userId"));
            model.addAttribute("user", user);
            return "profile";
        }
        
        userDTO.setId((Long) session.getAttribute("userId"));
        
        if (userDAO.updateProfile(userDTO)) {
            session.setAttribute("userName", userDTO.getFullName());
            model.addAttribute("success", "Profile updated successfully!");
        } else {
            model.addAttribute("error", "Failed to update profile");
        }
        
        UserDTO updatedUser = userDAO.getUserWithStats((Long) session.getAttribute("userId"));
        model.addAttribute("user", updatedUser);
        return "profile";
    }
    
    @GetMapping("/admin")
    public String adminDashboard(HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (isAdmin == null || !isAdmin) {
            return "redirect:/dashboard";
        }
        
        List<UserDTO> allUsers = userDAO.getAllUsers();
        List<com.pkg.dto.RequestDTO> allRequests = requestDAO.getAllRequests();
        
        model.addAttribute("users", allUsers);
        model.addAttribute("requests", allRequests);
        model.addAttribute("topHelpers", userDAO.getTopHelpers(5));
        
        return "admin";  // ← WITHOUT .jsp
    }
    
    @PostMapping("/admin/user/{id}/toggle")
    public String toggleUserStatus(@PathVariable Long id, HttpSession session) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (isAdmin == null || !isAdmin) {
            return "redirect:/dashboard";
        }
        
        return "redirect:/admin";
    }
}