/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dht.service.impl;

import com.dht.pojo.Product;
import com.dht.pojo.Shop;
import com.dht.repository.ShopRepository;
import com.dht.service.ShopService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author ADMIN
 */
@Service
public class ShopServiceImpl implements ShopService{
    @Autowired
    private ShopRepository shopRepo;

    @Override
    public List<Shop> getShops() {
        return shopRepo.getShops();
    }

    @Override
    public List<Product> getProducts(int shopId) {
        return shopRepo.getProducts(shopId);
    }

    @Override
    public List<Shop> getShopsByUI(int userId) {
        return shopRepo.getShopsByUI(userId);
    }

    @Override
    public Shop getShopById(int shopId) {
        return shopRepo.getShopById(shopId);
    }

    @Override
    public boolean AddOrUpdateShop(Shop shop) {
        return this.shopRepo.AddOrUpdateShop(shop);
    }
}
