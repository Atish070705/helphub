package com.pkg.dao;

import com.pkg.dto.RequestDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class RequestDAO {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    private RowMapper<RequestDTO> requestRowMapper = new RowMapper<RequestDTO>() {
        @Override
        public RequestDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
            RequestDTO request = new RequestDTO();
            request.setId(rs.getLong("id"));
            request.setTitle(rs.getString("title"));
            request.setDescription(rs.getString("description"));
            request.setCategory(rs.getString("category"));
            request.setUrgency(rs.getString("urgency"));
            request.setStatus(rs.getString("status"));
            request.setAuthorId(rs.getLong("author_id"));
            request.setLocation(rs.getString("location"));
            request.setCreatedAt(rs.getTimestamp("created_at"));
            return request;
        }
    };
    
    public List<RequestDTO> getAllOpenRequests() {
        String sql = "SELECT r.*, u.first_name, u.last_name, u.email " +
                     "FROM requests r " +
                     "JOIN users u ON r.author_id = u.id " +
                     "WHERE r.status != 'RESOLVED' " +
                     "ORDER BY CASE r.urgency WHEN 'HIGH' THEN 1 WHEN 'MEDIUM' THEN 2 WHEN 'LOW' THEN 3 END, r.created_at DESC";
        return jdbcTemplate.query(sql, new RowMapper<RequestDTO>() {
            @Override
            public RequestDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
                RequestDTO request = requestRowMapper.mapRow(rs, rowNum);
                request.setAuthorFirstName(rs.getString("first_name"));
                request.setAuthorLastName(rs.getString("last_name"));
                request.setAuthorEmail(rs.getString("email"));
                return request;
            }
        });
    }
    
    public List<RequestDTO> getRequestsByUser(Long userId) {
        String sql = "SELECT * FROM requests WHERE author_id = ? ORDER BY created_at DESC";
        return jdbcTemplate.query(sql, requestRowMapper, userId);
    }
    
    public RequestDTO getRequestById(Long requestId) {
        String sql = "SELECT r.*, u.first_name, u.last_name, u.email " +
                     "FROM requests r " +
                     "JOIN users u ON r.author_id = u.id " +
                     "WHERE r.id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new RowMapper<RequestDTO>() {
                @Override
                public RequestDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
                    RequestDTO request = requestRowMapper.mapRow(rs, rowNum);
                    request.setAuthorFirstName(rs.getString("first_name"));
                    request.setAuthorLastName(rs.getString("last_name"));
                    request.setAuthorEmail(rs.getString("email"));
                    return request;
                }
            }, requestId);
        } catch (Exception e) {
            return null;
        }
    }
    
    public boolean createRequest(RequestDTO request) {
        String sql = "INSERT INTO requests (title, description, category, urgency, status, author_id, location) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            return jdbcTemplate.update(sql, request.getTitle(), request.getDescription(),
                                      request.getCategory(), request.getUrgency(), "OPEN",
                                      request.getAuthorId(), request.getLocation()) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateRequestStatus(Long requestId, String status) {
        String sql = "UPDATE requests SET status = ? WHERE id = ?";
        try {
            return jdbcTemplate.update(sql, status, requestId) > 0;
        } catch (Exception e) {
            return false;
        }
    }
    
    public List<RequestDTO> getRequestsByCategory(String category) {
        String sql = "SELECT r.*, u.first_name, u.last_name, u.email " +
                     "FROM requests r " +
                     "JOIN users u ON r.author_id = u.id " +
                     "WHERE r.category = ? AND r.status != 'RESOLVED' " +
                     "ORDER BY CASE r.urgency WHEN 'HIGH' THEN 1 WHEN 'MEDIUM' THEN 2 WHEN 'LOW' THEN 3 END, r.created_at DESC";
        return jdbcTemplate.query(sql, new RowMapper<RequestDTO>() {
            @Override
            public RequestDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
                RequestDTO request = new RequestDTO();
                request.setId(rs.getLong("id"));
                request.setTitle(rs.getString("title"));
                request.setDescription(rs.getString("description"));
                request.setCategory(rs.getString("category"));
                request.setUrgency(rs.getString("urgency"));
                request.setStatus(rs.getString("status"));
                request.setAuthorId(rs.getLong("author_id"));
                request.setLocation(rs.getString("location"));
                request.setCreatedAt(rs.getTimestamp("created_at"));
                request.setAuthorFirstName(rs.getString("first_name"));
                request.setAuthorLastName(rs.getString("last_name"));
                request.setAuthorEmail(rs.getString("email"));
                return request;
            }
        }, category);
    }

 // Search requests by keyword
    public List<RequestDTO> searchRequests(String keyword) {
        String sql = "SELECT r.*, u.first_name, u.last_name, u.email " +
                     "FROM requests r " +
                     "JOIN users u ON r.author_id = u.id " +
                     "WHERE (r.title LIKE ? OR r.description LIKE ?) AND r.status != 'RESOLVED' " +
                     "ORDER BY CASE r.urgency WHEN 'HIGH' THEN 1 WHEN 'MEDIUM' THEN 2 WHEN 'LOW' THEN 3 END, r.created_at DESC";
        String searchPattern = "%" + keyword + "%";
        return jdbcTemplate.query(sql, new RowMapper<RequestDTO>() {
            @Override
            public RequestDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
                RequestDTO request = new RequestDTO();
                request.setId(rs.getLong("id"));
                request.setTitle(rs.getString("title"));
                request.setDescription(rs.getString("description"));
                request.setCategory(rs.getString("category"));
                request.setUrgency(rs.getString("urgency"));
                request.setStatus(rs.getString("status"));
                request.setAuthorId(rs.getLong("author_id"));
                request.setLocation(rs.getString("location"));
                request.setCreatedAt(rs.getTimestamp("created_at"));
                request.setAuthorFirstName(rs.getString("first_name"));
                request.setAuthorLastName(rs.getString("last_name"));
                request.setAuthorEmail(rs.getString("email"));
                return request;
            }
        }, searchPattern, searchPattern);
    }
    
    public List<RequestDTO> getAllRequests() {
        String sql = "SELECT r.*, u.first_name, u.last_name, u.email " +
                     "FROM requests r " +
                     "JOIN users u ON r.author_id = u.id " +
                     "ORDER BY r.created_at DESC";
        return jdbcTemplate.query(sql, new RowMapper<RequestDTO>() {
            @Override
            public RequestDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
                RequestDTO request = requestRowMapper.mapRow(rs, rowNum);
                request.setAuthorFirstName(rs.getString("first_name"));
                request.setAuthorLastName(rs.getString("last_name"));
                request.setAuthorEmail(rs.getString("email"));
                return request;
            }
        });
    }
}