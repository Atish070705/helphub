<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="My Profile" />
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
    <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i> <%= request.getAttribute("success") %>
        </div>
    <% } %>
    
    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error">
            <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %>
        </div>
    <% } %>
    
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-value">${user.karmaPoints}</div>
            <div class="stat-label"><i class="fas fa-star"></i> Karma Points</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">${user.totalRequests}</div>
            <div class="stat-label"><i class="fas fa-pen-alt"></i> Requests Posted</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">${user.totalResponses}</div>
            <div class="stat-label"><i class="fas fa-reply"></i> Responses Given</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">${user.helpfulResponses}</div>
            <div class="stat-label"><i class="fas fa-thumbs-up"></i> Helpful Responses</div>
        </div>
    </div>
    
    <div class="card" style="margin-top: var(--space-xl);">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: var(--space-lg);">
            <h2><i class="fas fa-user-circle"></i> Profile Information</h2>
            <button onclick="toggleEdit()" class="btn-secondary" id="editBtn">
                <i class="fas fa-edit"></i> Edit Profile
            </button>
        </div>
        
        <div id="viewMode">
            <div class="grid" style="grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: var(--space-lg);">
                <div>
                    <label style="color: var(--gray-500); font-size: 0.875rem;">Full Name</label>
                    <p style="font-size: 1.125rem; font-weight: 500;">${user.fullName}</p>
                </div>
                <div>
                    <label style="color: var(--gray-500); font-size: 0.875rem;">Email</label>
                    <p style="font-size: 1.125rem; font-weight: 500;">${user.email}</p>
                </div>
                <div>
                    <label style="color: var(--gray-500); font-size: 0.875rem;">Phone</label>
                    <p style="font-size: 1.125rem; font-weight: 500;">${user.phone}</p>
                </div>
                <div>
                    <label style="color: var(--gray-500); font-size: 0.875rem;">City</label>
                    <p style="font-size: 1.125rem; font-weight: 500;">${user.city}</p>
                </div>
                <div>
                    <label style="color: var(--gray-500); font-size: 0.875rem;">Member Since</label>
                    <p style="font-size: 1.125rem; font-weight: 500;"><fmt:formatDate value="${user.createdAt}" pattern="MMM dd, yyyy"/></p>
                </div>
            </div>
        </div>
        
        <div id="editMode" style="display: none;">
            <form action="/profile/update" method="post">
                <div class="grid" style="grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: var(--space-lg);">
                    <div class="form-group">
                        <label>First Name</label>
                        <input type="text" name="firstName" value="${user.firstName}" required>
                    </div>
                    <div class="form-group">
                        <label>Last Name</label>
                        <input type="text" name="lastName" value="${user.lastName}" required>
                    </div>
                    <div class="form-group">
                        <label>Phone</label>
                        <input type="tel" name="phone" value="${user.phone}" required>
                    </div>
                    <div class="form-group">
                        <label>City</label>
                        <input type="text" name="city" value="${user.city}" required>
                    </div>
                </div>
                <div class="flex" style="margin-top: var(--space-lg);">
                    <button type="submit" class="btn-primary">
                        <i class="fas fa-save"></i> Save Changes
                    </button>
                    <button type="button" class="btn-secondary" onclick="toggleEdit()">
                        <i class="fas fa-times"></i> Cancel
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function toggleEdit() {
        var viewMode = document.getElementById('viewMode');
        var editMode = document.getElementById('editMode');
        var editBtn = document.getElementById('editBtn');
        
        if (viewMode.style.display === 'none') {
            viewMode.style.display = 'block';
            editMode.style.display = 'none';
            editBtn.innerHTML = '<i class="fas fa-edit"></i> Edit Profile';
        } else {
            viewMode.style.display = 'none';
            editMode.style.display = 'block';
            editBtn.innerHTML = '<i class="fas fa-times"></i> Cancel';
        }
    }
</script>

<jsp:include page="footer.jsp" />