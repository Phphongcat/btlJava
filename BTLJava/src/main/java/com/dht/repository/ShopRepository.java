/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.dht.repository;

import com.dht.pojo.Product;
import com.dht.pojo.Shop;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public interface ShopRepository {
    Shop getShop();
    List<Product> getProducts();
}
