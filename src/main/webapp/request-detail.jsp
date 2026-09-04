<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Request Details" />
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
    <a href="/dashboard" style="display: inline-block; margin-bottom: var(--space-lg); color: var(--primary);">
        <i class="fas fa-arrow-left"></i> Back to Dashboard
    </a>
    
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
    
    <div class="card" style="margin-bottom: var(--space-xl);">
        <div class="request-title" style="font-size: 1.75rem;">${request.title}</div>
        <div class="request-meta" style="margin-top: var(--space-md);">
            <span><i class="fas fa-user"></i> Posted by: ${request.authorFullName}</span>
            <span><i class="fas fa-envelope"></i> ${request.authorEmail}</span>
            <span><i class="fas fa-map-marker-alt"></i> ${request.location}</span>
            <span><i class="far fa-calendar-alt"></i> <fmt:formatDate value="${request.createdAt}" pattern="MMM dd, yyyy HH:mm"/></span>
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
            <span class="badge badge-${request.status == 'OPEN' ? 'open' : (request.status == 'IN_PROGRESS' ? 'progress' : 'resolved')}">
                <i class="fas fa-${request.status == 'OPEN' ? 'circle' : (request.status == 'IN_PROGRESS' ? 'sync-alt' : 'check')}"></i> ${request.status}
            </span>
        </div>
        <div class="request-description" style="margin-top: var(--space-lg); line-height: 1.8;">
            ${request.description}
        </div>
    </div>
    
    <div class="card">
        <h2><i class="fas fa-comments"></i> Responses (${responses.size()})</h2>
        
        <c:if test="${empty responses}">
            <div class="empty-state">
                <i class="fas fa-comment-slash" style="font-size: 3rem; color: var(--gray-400);"></i>
                <p>No responses yet. Be the first to help!</p>
            </div>
        </c:if>
        
        <c:forEach items="${responses}" var="response">
            <div class="response-card">
                <div class="response-header" style="display: flex; justify-content: space-between; margin-bottom: var(--space-sm);">
                    <div>
                        <strong><i class="fas fa-user-circle"></i> ${response.helperFullName}</strong>
                        <span style="color: var(--gray-500); font-size: 0.875rem;"> (${response.helperEmail})</span>
                    </div>
                    <span style="color: var(--gray-500); font-size: 0.875rem;">
                        <i class="far fa-clock"></i> <fmt:formatDate value="${response.createdAt}" pattern="MMM dd, yyyy HH:mm"/>
                    </span>
                </div>
                <div class="response-content" style="margin-bottom: var(--space-sm);">
                    ${response.content}
                </div>
                <div>
                    <c:if test="${request.authorId == currentUserId && !response.isHelpful}">
                        <form action="/response/${response.id}/helpful" method="post" style="display: inline;">
                            <button type="submit" class="btn-success" style="padding: 4px 12px; font-size: 0.875rem;">
                                <i class="fas fa-thumbs-up"></i> Mark as Helpful
                            </button>
                        </form>
                    </c:if>
                    <c:if test="${response.isHelpful}">
                        <span class="badge badge-success" style="background: var(--success); color: white;">
                            <i class="fas fa-check-circle"></i> Marked as helpful (+10 karma)
                        </span>
                    </c:if>
                </div>
            </div>
        </c:forEach>
        
        <c:if test="${request.authorId != currentUserId && request.status != 'RESOLVED' && !hasResponded}">
            <div class="add-response" style="margin-top: var(--space-xl); padding-top: var(--space-xl); border-top: 1px solid var(--gray-200);">
                <h3><i class="fas fa-reply"></i> Offer Help</h3>
                <form action="/request/${request.id}/respond" method="post">
                    <textarea name="content" required placeholder="Write your response here... How can you help?"></textarea>
                    <button type="submit" class="btn-primary" style="margin-top: var(--space-md);">
                        <i class="fas fa-paper-plane"></i> Submit Response
                    </button>
                </form>
            </div>
        </c:if>
        
        <c:if test="${hasResponded}">
            <div class="alert alert-success" style="margin-top: var(--space-lg);">
                <i class="fas fa-check-circle"></i> You have already responded to this request. Thank you for helping!
            </div>
        </c:if>
        
        <c:if test="${request.status == 'RESOLVED'}">
            <div class="alert alert-success" style="margin-top: var(--space-lg);">
                <i class="fas fa-check-double"></i> This request has been marked as resolved. Thank you to everyone who helped!
            </div>
        </c:if>
    </div>
</div>

<jsp:include page="footer.jsp" />