/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dht.service.impl;

import com.dht.pojo.Product;
import com.dht.pojo.Shop;
import com.dht.pojo.User;
import com.dht.repository.ShopRepository;
import com.dht.service.ShopService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;

/**
 *
 * @author ADMIN
 */
public class ShopServiceImpl implements ShopService{

    @Autowired
    private ShopRepository shopRepo;
    
    @Override
    public List<Shop> getShops(User user) {
        return shopRepo.getShops(user);
    }
    
    @Override
    public List<Product> getProducts(int shop_id) {
        return shopRepo.getProducts(shop_id);
    }
}
