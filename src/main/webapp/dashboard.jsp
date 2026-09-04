<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Dashboard" />
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
    <div class="header">
        <div>
            <h1><i class="fas fa-hands-helping"></i> Help Requests</h1>
            <p style="color: var(--gray-600);">Find ways to help others or get help from the community</p>
        </div>
        <div class="flex">
            <form action="/dashboard" method="get" class="search-bar">
    <input type="text" name="keyword" placeholder="Search requests..." 
           class="search-input" value="${param.keyword}">
    <button type="submit" class="btn-primary">
        <i class="fas fa-search"></i> Search
    </button>
</form>
            <a href="/add-request" class="btn-primary">
                <i class="fas fa-plus"></i> Post New Request
            </a>
        </div>
    </div>
    
    <div class="category-filter">
    <a href="/dashboard" class="filter-btn ${empty param.category ? 'active' : ''}">
        <i class="fas fa-globe"></i> All Requests
    </a>
    <a href="/dashboard?category=Technical Support" class="filter-btn ${param.category == 'Technical Support' ? 'active' : ''}">
        <i class="fas fa-laptop-code"></i> Technical Support
    </a>
    <a href="/dashboard?category=Academic Help" class="filter-btn ${param.category == 'Academic Help' ? 'active' : ''}">
        <i class="fas fa-graduation-cap"></i> Academic Help
    </a>
    <a href="/dashboard?category=Career Advice" class="filter-btn ${param.category == 'Career Advice' ? 'active' : ''}">
        <i class="fas fa-briefcase"></i> Career Advice
    </a>
    <a href="/dashboard?category=Mental Health" class="filter-btn ${param.category == 'Mental Health' ? 'active' : ''}">
        <i class="fas fa-heart"></i> Mental Health
    </a>
    <a href="/dashboard?category=Legal Advice" class="filter-btn ${param.category == 'Legal Advice' ? 'active' : ''}">
        <i class="fas fa-gavel"></i> Legal Advice
    </a>
    <a href="/dashboard?category=Language Learning" class="filter-btn ${param.category == 'Language Learning' ? 'active' : ''}">
        <i class="fas fa-language"></i> Language Learning
    </a>
</div>
    
    <c:if test="${not empty param.category}">
    <div class="alert alert-info">
        <i class="fas fa-filter"></i> Showing requests in category: <strong>${param.category}</strong>
        <a href="/dashboard" style="float: right; color: var(--primary); text-decoration: none;">
            <i class="fas fa-times"></i> Clear Filter
        </a>
    </div>
</c:if>

<c:if test="${not empty param.keyword}">
    <div class="alert alert-info">
        <i class="fas fa-search"></i> Search results for: <strong>"${param.keyword}"</strong>
        <a href="/dashboard" style="float: right; color: var(--primary); text-decoration: none;">
            <i class="fas fa-times"></i> Clear Search
        </a>
    </div>
</c:if>
    
    <c:if test="${not empty success}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i> ${success}
        </div>
    </c:if>
    
    <c:if test="${empty requests}">
        <div class="empty-state">
            <i class="fas fa-inbox"></i>
            <h3>No Requests Found</h3>
            <p>There are no help requests matching your criteria.</p>
            <c:if test="${not empty selectedCategory or not empty searchKeyword}">
                <a href="/dashboard" class="btn-primary" style="margin-top: var(--space-md);">
                    <i class="fas fa-arrow-left"></i> View All Requests
                </a>
            </c:if>
            <c:if test="${empty selectedCategory and empty searchKeyword}">
                <a href="/add-request" class="btn-primary" style="margin-top: var(--space-md);">
                    <i class="fas fa-plus"></i> Be the First to Post a Request
                </a>
            </c:if>
        </div>
    </c:if>
    
    <c:forEach items="${requests}" var="request">
        <div class="request-card" onclick="location.href='/request/${request.id}'">
            <div class="request-title">${request.title}</div>
            <div class="request-meta">
                <span><i class="fas fa-map-marker-alt"></i> ${request.location}</span>
                <span><i class="fas fa-user"></i> ${request.authorFullName}</span>
                <span><i class="far fa-calendar-alt"></i> <fmt:formatDate value="${request.createdAt}" pattern="MMM dd, yyyy"/></span>
                <span><i class="fas fa-tag"></i> ${request.category}</span>
                <c:choose>
                    <c:when test="${request.urgency == 'HIGH'}">
                        <span class="badge badge-high"><i class="fas fa-exclamation-circle"></i> HIGH URGENCY</span>
                    </c:when>
                    <c:when test="${request.urgency == 'MEDIUM'}">
                        <span class="badge badge-medium"><i class="fas fa-chart-line"></i> MEDIUM URGENCY</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge badge-low"><i class="fas fa-arrow-down"></i> LOW URGENCY</span>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="request-description">
                <c:choose>
                    <c:when test="${request.description.length() > 200}">
                        ${request.description.substring(0, 200)}...
                    </c:when>
                    <c:otherwise>
                        ${request.description}
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="request-footer" style="display: flex; justify-content: space-between; align-items: center; margin-top: var(--space-md);">
                <span class="badge badge-${request.status == 'OPEN' ? 'open' : (request.status == 'IN_PROGRESS' ? 'progress' : 'resolved')}">
                    <i class="fas fa-${request.status == 'OPEN' ? 'circle' : (request.status == 'IN_PROGRESS' ? 'sync-alt' : 'check')}"></i> ${request.status}
                </span>
                <span style="color: var(--primary); font-weight: 500;">
                    <i class="fas fa-arrow-right"></i> View & Help
                </span>
            </div>
        </div>
    </c:forEach>
    
    <c:if test="${not empty requests}">
        <div style="text-align: center; margin-top: var(--space-xl); padding: var(--space-lg); background: white; border-radius: var(--radius-lg);">
            <p style="color: var(--gray-600);">
                <i class="fas fa-chart-bar"></i> Showing ${requests.size()} request(s)
            </p>
        </div>
    </c:if>
</div>

<jsp:include page="footer.jsp" />