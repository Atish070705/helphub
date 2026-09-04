<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Post Request" />
</jsp:include>

<div class="navbar">
    <a href="/dashboard" class="logo">
        <i class="fas fa-hands-helping"></i> HelpHub
    </a>
    <div class="nav-links">
        <a href="/dashboard"><i class="fas fa-home"></i> Home</a>
        <a href="/my-requests"><i class="fas fa-list"></i> My Requests</a>
        <a href="/profile"><i class="fas fa-user"></i> Profile</a>
        <a href="/logout" class="btn-logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
</div>

<div class="container fade-in">
    <div class="form-container" style="max-width: 700px; margin: 0 auto;">
        <div class="text-center" style="margin-bottom: var(--space-xl);">
            <i class="fas fa-pen-alt" style="font-size: 3rem; color: var(--primary); margin-bottom: var(--space-sm);"></i>
            <h2>Post a Help Request</h2>
            <p style="color: var(--gray-600);">Describe what you need help with</p>
        </div>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <form action="/add-request" method="post">
            <div class="form-group">
                <label for="title"><i class="fas fa-heading"></i> Title *</label>
                <input type="text" id="title" name="title" required 
                       placeholder="Brief summary of your request">
            </div>
            
            <div class="form-group">
                <label for="description"><i class="fas fa-align-left"></i> Description *</label>
                <textarea id="description" name="description" required 
                          placeholder="Provide detailed information about what you need help with..."></textarea>
            </div>
            
            <div class="form-group">
                <label for="category"><i class="fas fa-tag"></i> Category *</label>
                <select id="category" name="category" required>
                    <option value="">Select a category</option>
                    <option value="Technical Support">💻 Technical Support</option>
                    <option value="Academic Help">📚 Academic Help</option>
                    <option value="Career Advice">💼 Career Advice</option>
                    <option value="Mental Health">❤️ Mental Health</option>
                    <option value="Legal Advice">⚖️ Legal Advice</option>
                    <option value="Language Learning">🌐 Language Learning</option>
                    <option value="Other">📌 Other</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="urgency"><i class="fas fa-exclamation-triangle"></i> Urgency *</label>
                <select id="urgency" name="urgency" required>
                    <option value="">Select urgency level</option>
                    <option value="HIGH">🔴 High - Need immediate help</option>
                    <option value="MEDIUM">🟡 Medium - Need help within a few days</option>
                    <option value="LOW">🟢 Low - No immediate rush</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="location"><i class="fas fa-map-marker-alt"></i> Location *</label>
                <input type="text" id="location" name="location" required 
                       placeholder="City or area">
            </div>
            
            <div class="flex" style="gap: var(--space-md);">
                <button type="submit" class="btn-primary" style="flex: 1;">
                    <i class="fas fa-paper-plane"></i> Post Request
                </button>
                <button type="button" class="btn-secondary" style="flex: 1;" onclick="location.href='/dashboard'">
                    <i class="fas fa-times"></i> Cancel
                </button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="footer.jsp" />