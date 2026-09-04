<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Login" />
</jsp:include>

<div class="container fade-in" style="min-height: 80vh; display: flex; align-items: center; justify-content: center;">
    <div class="form-container" style="max-width: 450px;">
        <div class="text-center" style="margin-bottom: var(--space-xl);">
            <i class="fas fa-hands-helping" style="font-size: 3rem; color: var(--primary); margin-bottom: var(--space-sm);"></i>
            <h2>Welcome Back!</h2>
            <p style="color: var(--gray-600);">Login to continue to HelpHub</p>
        </div>
        
        <% if (request.getParameter("logout") != null) { %>
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> You have been logged out successfully.
            </div>
        <% } %>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <% if (request.getAttribute("success") != null) { %>
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> <%= request.getAttribute("success") %>
            </div>
        <% } %>
        
        <form action="/login" method="post">
            <div class="form-group">
                <label for="email"><i class="fas fa-envelope"></i> Email Address</label>
                <input type="email" id="email" name="email" required placeholder="your@email.com">
            </div>
            
            <div class="form-group">
                <label for="password"><i class="fas fa-lock"></i> Password</label>
                <input type="password" id="password" name="password" required placeholder="••••••••">
            </div>
            
            <button type="submit" class="btn-primary" style="width: 100%;">
                <i class="fas fa-sign-in-alt"></i> Login
            </button>
        </form>
        
        <div class="text-center" style="margin-top: var(--space-lg);">
            <p style="color: var(--gray-600);">Don't have an account? <a href="/register" style="color: var(--primary);">Create one now</a></p>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />