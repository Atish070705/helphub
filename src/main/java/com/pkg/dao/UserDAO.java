package com.pkg.dao;

import com.pkg.dto.UserDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class UserDAO {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    private RowMapper<UserDTO> userRowMapper = new RowMapper<UserDTO>() {
        @Override
        public UserDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
            UserDTO user = new UserDTO();
            user.setId(rs.getLong("id"));
            user.setFirstName(rs.getString("first_name"));
            user.setLastName(rs.getString("last_name"));
            user.setEmail(rs.getString("email"));
            user.setPassword(rs.getString("password"));
            user.setPhone(rs.getString("phone"));
            user.setCity(rs.getString("city"));
            user.setKarmaPoints(rs.getInt("karma_points"));
            user.setCreatedAt(rs.getTimestamp("created_at"));
            user.setEnabled(rs.getBoolean("enabled"));
            return user;
        }
    };
    
    public UserDTO findByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try {
            return jdbcTemplate.queryForObject(sql, userRowMapper, email);
        } catch (Exception e) {
            return null;
        }
    }
    
    public UserDTO findById(Long id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, userRowMapper, id);
        } catch (Exception e) {
            return null;
        }
    }
    
    public boolean register(UserDTO user) {
        String sql = "INSERT INTO users (first_name, last_name, email, password, phone, city, karma_points, enabled) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            int result = jdbcTemplate.update(sql, 
                user.getFirstName(), 
                user.getLastName(), 
                user.getEmail(), 
                user.getPassword(),
                user.getPhone(),
                user.getCity(),
                0,
                true
            );
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean validateUser(String email, String password) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ? AND password = ? AND enabled = true";
        try {
            Integer count = jdbcTemplate.queryForObject(sql, Integer.class, email, password);
            return count != null && count > 0;
        } catch (Exception e) {
            return false;
        }
    }
    
    public UserDTO getUserWithStats(Long userId) {
        String sql = "SELECT u.*, " +
                     "(SELECT COUNT(*) FROM requests WHERE author_id = u.id) as total_requests, " +
                     "(SELECT COUNT(*) FROM responses WHERE helper_id = u.id) as total_responses, " +
                     "(SELECT COUNT(*) FROM responses WHERE helper_id = u.id AND is_helpful = true) as helpful_responses " +
                     "FROM users u WHERE u.id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new RowMapper<UserDTO>() {
                @Override
                public UserDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
                    UserDTO user = userRowMapper.mapRow(rs, rowNum);
                    user.setTotalRequests(rs.getInt("total_requests"));
                    user.setTotalResponses(rs.getInt("total_responses"));
                    user.setHelpfulResponses(rs.getInt("helpful_responses"));
                    return user;
                }
            }, userId);
        } catch (Exception e) {
            return null;
        }
    }
    
    public List<UserDTO> getTopHelpers(int limit) {
        String sql = "SELECT first_name, last_name, email, city, karma_points " +
                     "FROM users ORDER BY karma_points DESC LIMIT ?";
        return jdbcTemplate.query(sql, new RowMapper<UserDTO>() {
            @Override
            public UserDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
                UserDTO user = new UserDTO();
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setEmail(rs.getString("email"));
                user.setCity(rs.getString("city"));
                user.setKarmaPoints(rs.getInt("karma_points"));
                return user;
            }
        }, limit);
    }
    
    public boolean updateKarmaPoints(Long userId, int points) {
        String sql = "UPDATE users SET karma_points = karma_points + ? WHERE id = ?";
        try {
            return jdbcTemplate.update(sql, points, userId) > 0;
        } catch (Exception e) {
            return false;
        }
    }
    
    public boolean updateProfile(UserDTO user) {
        String sql = "UPDATE users SET first_name = ?, last_name = ?, phone = ?, city = ? WHERE id = ?";
        try {
            return jdbcTemplate.update(sql, user.getFirstName(), user.getLastName(), 
                                       user.getPhone(), user.getCity(), user.getId()) > 0;
        } catch (Exception e) {
            return false;
        }
    }
    
    public List<UserDTO> getAllUsers() {
        String sql = "SELECT * FROM users ORDER BY created_at DESC";
        return jdbcTemplate.query(sql, userRowMapper);
    }
}