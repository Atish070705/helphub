<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Register" />
</jsp:include>

<div class="container fade-in" style="min-height: 80vh; display: flex; align-items: center; justify-content: center;">
    <div class="form-container" style="max-width: 500px;">
        <div class="text-center" style="margin-bottom: var(--space-xl);">
            <i class="fas fa-user-plus" style="font-size: 3rem; color: var(--primary); margin-bottom: var(--space-sm);"></i>
            <h2>Create Account</h2>
            <p style="color: var(--gray-600);">Join HelpHub community today</p>
        </div>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <form action="/register" method="post">
            <div class="form-group">
                <label for="firstName"><i class="fas fa-user"></i> First Name</label>
                <input type="text" id="firstName" name="firstName" required>
            </div>
            
            <div class="form-group">
                <label for="lastName"><i class="fas fa-user"></i> Last Name</label>
                <input type="text" id="lastName" name="lastName" required>
            </div>
            
            <div class="form-group">
                <label for="email"><i class="fas fa-envelope"></i> Email Address</label>
                <input type="email" id="email" name="email" required>
            </div>
            
            <div class="form-group">
                <label for="password"><i class="fas fa-lock"></i> Password</label>
                <input type="password" id="password" name="password" required>
                <small style="color: var(--gray-500);">Minimum 6 characters</small>
            </div>
            
            <div class="form-group">
                <label for="phone"><i class="fas fa-phone"></i> Phone Number</label>
                <input type="tel" id="phone" name="phone" required>
            </div>
            
            <div class="form-group">
                <label for="city"><i class="fas fa-city"></i> City</label>
                <input type="text" id="city" name="city" required>
            </div>
            
            <button type="submit" class="btn-primary" style="width: 100%;">
                <i class="fas fa-user-plus"></i> Create Account
            </button>
        </form>
        
        <div class="text-center" style="margin-top: var(--space-lg);">
            <p style="color: var(--gray-600);">Already have an account? <a href="/login" style="color: var(--primary);">Login here</a></p>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />