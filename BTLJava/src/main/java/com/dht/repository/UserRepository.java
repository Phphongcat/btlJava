/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dht.repository;

import com.dht.pojo.User;
import java.util.List;

/**
 *
 * @author admin
 */
public interface UserRepository {
    User getUserByUsername(String username);
    User getUserById(int userId);
    boolean authUser(String username, String password);
    User addUser(User user);
    List<User> getUserUnactives();
} 
