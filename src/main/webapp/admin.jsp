<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Admin Dashboard" />
</jsp:include>

<div class="navbar">
    <a href="/admin" class="logo">
        <i class="fas fa-shield-alt"></i> HelpHub Admin
    </a>
    <div class="nav-links">
        <a href="/dashboard"><i class="fas fa-home"></i> User Dashboard</a>
        <a href="/profile"><i class="fas fa-user"></i> Profile</a>
        <a href="/logout" class="btn-logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
</div>

<div class="container fade-in">
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-value">${users.size()}</div>
            <div class="stat-label"><i class="fas fa-users"></i> Total Users</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">${requests.size()}</div>
            <div class="stat-label"><i class="fas fa-tasks"></i> Total Requests</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">${topHelpers.size()}</div>
            <div class="stat-label"><i class="fas fa-trophy"></i> Top Helpers</div>
        </div>
    </div>
    
    <div class="card" style="margin-bottom: var(--space-xl);">
        <h2><i class="fas fa-trophy"></i> Top Helpers by Karma</h2>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Rank</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>City</th>
                        <th>Karma Points</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${topHelpers}" var="helper" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td><strong>${helper.firstName} ${helper.lastName}</strong></td>
                            <td>${helper.email}</td>
                            <td>${helper.city}</td>
                            <td><i class="fas fa-star" style="color: #f59e0b;"></i> ${helper.karmaPoints}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    
    <div class="card" style="margin-bottom: var(--space-xl);">
        <h2><i class="fas fa-users"></i> All Users</h2>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>City</th>
                        <th>Karma</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${users}" var="user">
                        <tr>
                            <td>${user.id}</td>
                            <td><strong>${user.firstName} ${user.lastName}</strong></td>
                            <td>${user.email}</td>
                            <td>${user.city}</td>
                            <td><i class="fas fa-star" style="color: #f59e0b;"></i> ${user.karmaPoints}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${user.enabled}">
                                        <span class="badge badge-open"><i class="fas fa-check-circle"></i> Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-high"><i class="fas fa-ban"></i> Disabled</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <form action="/admin/user/${user.id}/toggle" method="post">
                                    <button type="submit" class="btn-secondary" style="padding: 4px 12px; font-size: 0.75rem;">
                                        <c:choose>
                                            <c:when test="${user.enabled}">
                                                <i class="fas fa-ban"></i> Disable
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-check"></i> Enable
                                            </c:otherwise>
                                        </c:choose>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    
    <div class="card">
        <h2><i class="fas fa-tasks"></i> All Requests</h2>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Author</th>
                        <th>Category</th>
                        <th>Urgency</th>
                        <th>Status</th>
                        <th>Created</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${requests}" var="req">
                        <tr>
                            <td>${req.id}</td>
                            <td>${req.title}</td>
                            <td>${req.authorFirstName} ${req.authorLastName}</td>
                            <td>${req.category}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${req.urgency == 'HIGH'}">
                                        <span class="badge badge-high">HIGH</span>
                                    </c:when>
                                    <c:when test="${req.urgency == 'MEDIUM'}">
                                        <span class="badge badge-medium">MEDIUM</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-low">LOW</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <span class="badge badge-${req.status == 'OPEN' ? 'open' : (req.status == 'IN_PROGRESS' ? 'progress' : 'resolved')}">
                                    ${req.status}
                                </span>
                            </td>
                            <td><fmt:formatDate value="${req.createdAt}" pattern="MMM dd, yyyy"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />