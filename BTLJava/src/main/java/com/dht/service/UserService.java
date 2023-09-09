/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dht.service;

import com.dht.pojo.User;
import java.util.List;
import java.util.Map;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author admin
 */
public interface UserService extends UserDetailsService  {
    User getUserByUn(String username);
    User getUserById(int userId);
    boolean authUser(String username, String password);
    User addUser(Map<String, String> params, MultipartFile avatar);
    List<User> getSaleUsers();
    boolean updateSaleUser(User user);
}
