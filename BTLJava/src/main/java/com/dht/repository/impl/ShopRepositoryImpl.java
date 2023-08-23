package com.dht.repository.impl;

import com.dht.pojo.Product;
import com.dht.pojo.Shop;
import com.dht.pojo.User;
import com.dht.repository.ShopRepository;
import java.util.List;
import javax.persistence.Query;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author ADMIN
 */
@Repository
@Transactional
public class ShopRepositoryImpl implements ShopRepository {
    @Autowired
    private LocalSessionFactoryBean factory;

    @Override
    public List<Shop> getShops(User user) {
        Session s = this.factory.getObject().getCurrentSession();
        Query q;
        q = s.createQuery("From shop Where user_id=:un");
        q.setParameter("un", user.getId());
        
        return (List<Shop>) q.getSingleResult();
    }

    @Override
    public List<Product> getProducts(int shop_id) {
        Session s = this.factory.getObject().getCurrentSession();
        Query q;
        q = s.createQuery("From product Where shop_id =:un");
        q.setParameter("un", shop_id);
        
        return (List<Product>) q.getSingleResult();
    }
}
