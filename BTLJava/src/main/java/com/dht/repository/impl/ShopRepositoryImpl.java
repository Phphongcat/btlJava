/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dht.repository.impl;

import com.dht.pojo.Product;
import com.dht.pojo.Shop;
import com.dht.repository.ShopRepository;
import com.dht.repository.UserRepository;
import java.util.List;
import org.hibernate.Session;
import javax.persistence.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author ADMIN
 */
@Repository
@Transactional
public class ShopRepositoryImpl implements ShopRepository{
    @Autowired
    private UserRepository userRepo;
    @Autowired
    private LocalSessionFactoryBean factory;

    
    @Override
    public Shop getShop() {
        Authentication authentication
                = SecurityContextHolder.getContext().getAuthentication();
        Session s = this.factory.getObject().getCurrentSession();
        Query q = s.createQuery("From Shop where userId= :uid")
                .setParameter("uid", 
                        this.userRepo.getUserByUsername(authentication.getName()).getId());
        return (Shop) q.getSingleResult();
    }
    
    @Override
    public List<Product> getProducts() {
       Session s = this.factory.getObject().getCurrentSession();
       Query q = s.createQuery("From Product where shop_id= :sid")
               .setParameter("sid", getShop().getId());
       return q.getResultList();
    }
}
