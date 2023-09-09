/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dht.repository.impl;

import com.dht.pojo.Product;
import com.dht.pojo.Shop;
import com.dht.repository.ProductRepository;
import com.dht.repository.ShopRepository;
import com.dht.repository.UserRepository;
import java.io.Console;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Session;
import javax.persistence.Query;
import org.hibernate.HibernateException;
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
    public List<Shop> getShops() {
        Session s = this.factory.getObject().getCurrentSession();
        Query q = s.createQuery("From Shop");
        return q.getResultList();
    }

    @Override
    public List<Shop> getShopsByUI(int userId) {
        List<Shop> shops = new ArrayList<Shop>();
        for (Shop s : getShops()) 
        {
            if(s.getUserId().getId() == userId)
                shops.add(s);
        }
        return shops;
    }
    
    @Override
    public List<Product> getProducts(int shopId) {
        Session s = this.factory.getObject().getCurrentSession();
        Query q = s.createQuery("From Product");
        List<Product> products = q.getResultList();
        List<Product> results = new ArrayList<Product>();
        for(Product p : products)
        {
            if(p.getShopId().getId() == shopId)
                results.add(p);
        }
       return results;
    }

    @Override
    public Shop getShopById(int shopId) {
        for(Shop s : getShops())
        {
            if(s.getId() == shopId)
                return s;
        }
       return null;
    }

    @Override
    public boolean AddOrUpdateShop(Shop shop) {
        Session s = this.factory.getObject().getCurrentSession();
        try {
            if (shop.getId() == null) {
                s.save(shop);
            } else {
                s.update(shop);
            }

            return true;
        } catch (HibernateException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteShop(int shopId) {
        Session session = this.factory.getObject().getCurrentSession();
        Shop shop = this.getShopById(shopId);
        try {
            session.delete(shop);
            return true;
        } catch (HibernateException ex) {
            ex.printStackTrace();
            return false;
        }
    }
}
