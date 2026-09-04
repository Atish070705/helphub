package com.pkg.controller;

import com.pkg.dto.RequestDTO;
import com.pkg.dto.ResponseDTO;
import com.pkg.dao.RequestDAO;
import com.pkg.dao.ResponseDAO;
import com.pkg.dao.UserDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class RequestController {
    
    @Autowired
    private RequestDAO requestDAO;
    
    @Autowired
    private ResponseDAO responseDAO;
    
    @Autowired
    private UserDAO userDAO;
    
    @GetMapping("/dashboard")
    public String dashboard(@RequestParam(required = false) String category, 
                            @RequestParam(required = false) String keyword,
                            HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (isAdmin != null && isAdmin) {
            return "redirect:/admin";
        }
        
        List<RequestDTO> requests;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            requests = requestDAO.searchRequests(keyword);
            model.addAttribute("searchKeyword", keyword);
        } else if (category != null && !category.trim().isEmpty()) {
            requests = requestDAO.getRequestsByCategory(category);
            model.addAttribute("selectedCategory", category);
        } else {
            requests = requestDAO.getAllOpenRequests();
        }
        
        model.addAttribute("requests", requests);
        model.addAttribute("userName", session.getAttribute("userName"));
        return "dashboard";  // ← WITHOUT .jsp
    }
    
    @GetMapping("/add-request")
    public String showAddRequestForm(HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (isAdmin != null && isAdmin) {
            return "redirect:/admin";
        }
        
        model.addAttribute("requestDTO", new RequestDTO());
        return "add-request";  // ← WITHOUT .jsp
    }
    
    @PostMapping("/add-request")
    public String addRequest(@ModelAttribute RequestDTO requestDTO, HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (isAdmin != null && isAdmin) {
            return "redirect:/admin";
        }
        
        // Validation
        if (requestDTO.getTitle() == null || requestDTO.getTitle().trim().isEmpty()) {
            model.addAttribute("error", "Title is required");
            return "add-request";
        }
        if (requestDTO.getTitle().length() < 5) {
            model.addAttribute("error", "Title must be at least 5 characters");
            return "add-request";
        }
        if (requestDTO.getDescription() == null || requestDTO.getDescription().trim().isEmpty()) {
            model.addAttribute("error", "Description is required");
            return "add-request";
        }
        if (requestDTO.getDescription().length() < 10) {
            model.addAttribute("error", "Description must be at least 10 characters");
            return "add-request";
        }
        if (requestDTO.getCategory() == null || requestDTO.getCategory().trim().isEmpty()) {
            model.addAttribute("error", "Category is required");
            return "add-request";
        }
        if (requestDTO.getUrgency() == null || requestDTO.getUrgency().trim().isEmpty()) {
            model.addAttribute("error", "Urgency is required");
            return "add-request";
        }
        if (requestDTO.getLocation() == null || requestDTO.getLocation().trim().isEmpty()) {
            model.addAttribute("error", "Location is required");
            return "add-request";
        }
        
        requestDTO.setAuthorId((Long) session.getAttribute("userId"));
        
        if (requestDAO.createRequest(requestDTO)) {
            model.addAttribute("success", "Request posted successfully!");
            return "redirect:/dashboard";
        } else {
            model.addAttribute("error", "Failed to post request. Please try again.");
            return "add-request";
        }
    }
    
    @GetMapping("/request/{id}")
    public String viewRequest(@PathVariable Long id, HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        
        RequestDTO request = requestDAO.getRequestById(id);
        if (request == null) {
            return "redirect:/dashboard";
        }
        
        List<ResponseDTO> responses = responseDAO.getResponsesByRequest(id);
        boolean hasResponded = responseDAO.hasUserResponded(id, (Long) session.getAttribute("userId"));
        
        model.addAttribute("request", request);
        model.addAttribute("responses", responses);
        model.addAttribute("hasResponded", hasResponded);
        model.addAttribute("responseDTO", new ResponseDTO());
        model.addAttribute("currentUserId", session.getAttribute("userId"));
        
        return "request-detail";  // ← WITHOUT .jsp
    }
    
    @PostMapping("/request/{id}/respond")
    public String addResponse(@PathVariable Long id, @ModelAttribute ResponseDTO responseDTO, 
                              HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        
        if (responseDTO.getContent() == null || responseDTO.getContent().trim().isEmpty()) {
            model.addAttribute("error", "Response content is required");
            return "redirect:/request/" + id;
        }
        if (responseDTO.getContent().length() < 5) {
            model.addAttribute("error", "Response must be at least 5 characters");
            return "redirect:/request/" + id;
        }
        
        if (responseDAO.hasUserResponded(id, (Long) session.getAttribute("userId"))) {
            model.addAttribute("error", "You have already responded to this request");
            return "redirect:/request/" + id;
        }
        
        responseDTO.setRequestId(id);
        responseDTO.setHelperId((Long) session.getAttribute("userId"));
        
        if (responseDAO.addResponse(responseDTO)) {
            model.addAttribute("success", "Response added successfully!");
        } else {
            model.addAttribute("error", "Failed to add response");
        }
        
        return "redirect:/request/" + id;
    }
    
    @PostMapping("/response/{id}/helpful")
    public String markHelpful(@PathVariable Long id, HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        
        ResponseDTO response = responseDAO.getResponseById(id);
        if (response != null) {
            RequestDTO request = requestDAO.getRequestById(response.getRequestId());
            if (request.getAuthorId().equals(session.getAttribute("userId"))) {
                if (responseDAO.markAsHelpful(id)) {
                    model.addAttribute("success", "Response marked as helpful! +10 karma points to helper.");
                } else {
                    model.addAttribute("error", "Failed to mark as helpful");
                }
            } else {
                model.addAttribute("error", "Only the request author can mark responses as helpful");
            }
        }
        
        return "redirect:/request/" + (response != null ? response.getRequestId() : "");
    }
    
    @GetMapping("/my-requests")
    public String myRequests(HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        
        List<RequestDTO> requests = requestDAO.getRequestsByUser((Long) session.getAttribute("userId"));
        model.addAttribute("requests", requests);
        return "my-requests";  // ← WITHOUT .jsp
    }
    
    @PostMapping("/request/{id}/close")
    public String closeRequest(@PathVariable Long id, HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        
        RequestDTO request = requestDAO.getRequestById(id);
        if (request != null && request.getAuthorId().equals(session.getAttribute("userId"))) {
            if (requestDAO.updateRequestStatus(id, "RESOLVED")) {
                model.addAttribute("success", "Request marked as resolved!");
            } else {
                model.addAttribute("error", "Failed to close request");
            }
        } else {
            model.addAttribute("error", "You can only close your own requests");
        }
        
        return "redirect:/my-requests";
    }
}