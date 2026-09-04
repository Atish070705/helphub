<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="My Requests" />
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
            <h1><i class="fas fa-list-alt"></i> My Requests</h1>
            <p style="color: var(--gray-600);">Track and manage your help requests</p>
        </div>
        <a href="/add-request" class="btn-primary">
            <i class="fas fa-plus"></i> Post New Request
        </a>
    </div>
    
    <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i> <%= request.getAttribute("success") %>
        </div>
    <% } %>
    
    <c:if test="${empty requests}">
        <div class="empty-state">
            <i class="fas fa-inbox" style="font-size: 4rem; color: var(--gray-400); margin-bottom: var(--space-md);"></i>
            <p>You haven't posted any requests yet.</p>
            <p><a href="/add-request" style="color: var(--primary);">Post your first request</a></p>
        </div>
    </c:if>
    
    <c:forEach items="${requests}" var="request">
        <div class="request-card">
            <div class="request-title">${request.title}</div>
            <div class="request-meta">
                <span><i class="fas fa-map-marker-alt"></i> ${request.location}</span>
                <span><i class="far fa-calendar-alt"></i> <fmt:formatDate value="${request.createdAt}" pattern="MMM dd, yyyy"/></span>
                <span><i class="fas fa-tag"></i> ${request.category}</span>
                <c:choose>
                    <c:when test="${request.status == 'OPEN'}">
                        <span class="badge badge-open"><i class="fas fa-circle"></i> OPEN</span>
                    </c:when>
                    <c:when test="${request.status == 'IN_PROGRESS'}">
                        <span class="badge badge-progress"><i class="fas fa-sync-alt"></i> IN PROGRESS</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge badge-resolved"><i class="fas fa-check"></i> RESOLVED</span>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="request-description">
                <c:choose>
                    <c:when test="${request.description.length() > 150}">
                        ${request.description.substring(0, 150)}...
                    </c:when>
                    <c:otherwise>
                        ${request.description}
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="request-footer" style="display: flex; justify-content: space-between; align-items: center; margin-top: var(--space-md);">
                <a href="/request/${request.id}" class="btn-primary" style="padding: 6px 16px;">
                    <i class="fas fa-eye"></i> View Details
                </a>
                <c:if test="${request.status != 'RESOLVED'}">
                    <form action="/request/${request.id}/close" method="post" style="display: inline;">
                        <button type="submit" class="btn-success" style="padding: 6px 16px;" onclick="return confirm('Mark this request as resolved?')">
                            <i class="fas fa-check-circle"></i> Mark Resolved
                        </button>
                    </form>
                </c:if>
            </div>
        </div>
    </c:forEach>
</div>

<jsp:include page="footer.jsp" />