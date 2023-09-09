/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dht.repository.impl;

import com.dht.pojo.Shop;
import com.dht.pojo.User;
import com.dht.repository.UserRepository;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author admin
 */
@Repository
@Transactional
public class UserRepositoryImpl implements UserRepository {

    @Autowired
    private LocalSessionFactoryBean factory;
    @Autowired
    private BCryptPasswordEncoder passEncoder;

    @Override
    public User getUserByUsername(String username) {
        Session s = this.factory.getObject().getCurrentSession();
        Query q = s.createQuery("FROM User WHERE username=:un");
        q.setParameter("un", username);

        return (User) q.getSingleResult();
    }

    @Override
    public boolean authUser(String username, String password) {
        User  u = this.getUserByUsername(username);
        
        return this.passEncoder.matches(password, u.getPassword());
    }

    @Override
    public User addUser(User u) {
        Session s = this.factory.getObject().getCurrentSession();
        s.save(u);
        return u;
    }

    @Override
    public User getUserById(int userId) {
        Session s = this.factory.getObject().getCurrentSession();
        Query q = s.createQuery("FROM User WHERE id=:uid");
        q.setParameter("uid", userId);

        return (User) q.getSingleResult();
    }

    @Override
    public List<User> getSaleUsers() {
        Session session = this.factory.getObject().getCurrentSession();
        Query q = session.createQuery("FROM User");
        List<User> users = q.getResultList();
        List<User> results = new ArrayList<User>();
        for(User u : users)
        {
            if(u.getUserRole().equals("ROLE_SALE"))
                results.add(u);
        }
       return results;
    }
    
    @Override
    public boolean updateSaleUser(User user)
    {
        if(user.getUserRole().equals("ROLE_SALE"))
        {
            Session session = this.factory.getObject().getCurrentSession();
            try {
                session.update(user);
                return true;
            } catch (HibernateException ex) {
                ex.printStackTrace();
                return false;
            }
        }
        return false;
    }
}
