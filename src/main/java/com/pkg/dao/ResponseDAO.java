package com.pkg.dao;

import com.pkg.dto.ResponseDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class ResponseDAO {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    @Autowired
    private UserDAO userDAO;
    
    private RowMapper<ResponseDTO> responseRowMapper = new RowMapper<ResponseDTO>() {
        @Override
        public ResponseDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
            ResponseDTO response = new ResponseDTO();
            response.setId(rs.getLong("id"));
            response.setRequestId(rs.getLong("request_id"));
            response.setHelperId(rs.getLong("helper_id"));
            response.setContent(rs.getString("content"));
            response.setIsHelpful(rs.getBoolean("is_helpful"));
            response.setCreatedAt(rs.getTimestamp("created_at"));
            return response;
        }
    };
    
    public boolean addResponse(ResponseDTO response) {
        String sql = "INSERT INTO responses (request_id, helper_id, content, is_helpful) " +
                     "VALUES (?, ?, ?, ?)";
        try {
            return jdbcTemplate.update(sql, response.getRequestId(), response.getHelperId(),
                                      response.getContent(), false) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<ResponseDTO> getResponsesByRequest(Long requestId) {
        String sql = "SELECT r.*, u.first_name, u.last_name, u.email " +
                     "FROM responses r " +
                     "JOIN users u ON r.helper_id = u.id " +
                     "WHERE r.request_id = ? " +
                     "ORDER BY r.created_at DESC";
        return jdbcTemplate.query(sql, new RowMapper<ResponseDTO>() {
            @Override
            public ResponseDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
                ResponseDTO response = responseRowMapper.mapRow(rs, rowNum);
                response.setHelperFirstName(rs.getString("first_name"));
                response.setHelperLastName(rs.getString("last_name"));
                response.setHelperEmail(rs.getString("email"));
                return response;
            }
        }, requestId);
    }
    
    public boolean markAsHelpful(Long responseId) {
        String sql = "UPDATE responses SET is_helpful = true WHERE id = ?";
        try {
            // Get the helper_id before updating
            ResponseDTO response = getResponseById(responseId);
            if (response != null) {
                boolean updated = jdbcTemplate.update(sql, responseId) > 0;
                if (updated) {
                    // Add karma points to helper
                    userDAO.updateKarmaPoints(response.getHelperId(), 10);
                }
                return updated;
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public ResponseDTO getResponseById(Long responseId) {
        String sql = "SELECT * FROM responses WHERE id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, responseRowMapper, responseId);
        } catch (Exception e) {
            return null;
        }
    }
    
    public boolean hasUserResponded(Long requestId, Long userId) {
        String sql = "SELECT COUNT(*) FROM responses WHERE request_id = ? AND helper_id = ?";
        try {
            Integer count = jdbcTemplate.queryForObject(sql, Integer.class, requestId, userId);
            return count != null && count > 0;
        } catch (Exception e) {
            return false;
        }
    }
}