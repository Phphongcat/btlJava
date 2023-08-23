/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.dht.service;

import com.dht.pojo.Product;
import com.dht.pojo.Shop;
import com.dht.pojo.User;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public interface ShopService {
    List<Shop> getShops(User user);
    List<Product> getProducts(int shop_id);
}
