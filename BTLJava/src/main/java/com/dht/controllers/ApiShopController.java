/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dht.controllers;

import com.dht.pojo.Product;
import com.dht.pojo.Shop;
import com.dht.pojo.User;
import com.dht.service.ShopService;
import com.dht.service.UserService;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author Admin
 */
@RestController
@RequestMapping("/api")
public class ApiShopController {

    @Autowired
    private ShopService shopService;
    
    @Autowired
    private UserService userService;
    
    @RequestMapping(path = "/shops/")
    @CrossOrigin
    public ResponseEntity<List<Shop>> alllist() {
        return new ResponseEntity<>(this.shopService.getShops(), HttpStatus.OK);
    }
    
    @RequestMapping(path = "shops-by-user-id/{userId}/", produces = MediaType.APPLICATION_JSON_VALUE)
    @CrossOrigin
    public ResponseEntity<List<Shop>> list(@PathVariable(value = "userId") int id) {
        return new ResponseEntity<>(this.shopService.getShopsByUI(id), HttpStatus.OK);
    }
    
    @RequestMapping(path = "/products-by-shop-id/{shopId}/", produces = MediaType.APPLICATION_JSON_VALUE)
    @CrossOrigin
    public ResponseEntity<List<Product>> details(@PathVariable(value = "shopId") int id) {
        return new ResponseEntity<>(this.shopService.getProducts(id), HttpStatus.OK);
    }
    
    @RequestMapping(path = "/shops/{shopId}/", produces = MediaType.APPLICATION_JSON_VALUE)
    @CrossOrigin
    public ResponseEntity<Shop> shopdetail(@PathVariable(value = "shopId") int id) {
        return new ResponseEntity<>(this.shopService.getShopById(id), HttpStatus.OK);
    }
    
    @PostMapping(path = "/shop-add-update/", 
            consumes = {MediaType.MULTIPART_FORM_DATA_VALUE}, 
            produces = {MediaType.APPLICATION_JSON_VALUE})
    @CrossOrigin
    public ResponseEntity<Shop> addorupdate(@RequestParam Map<String, String> params) {
        Shop shop = new Shop();
        shop.setName(params.get("name"));
        shop.setDescription(params.get("description"));
        shop.setUserId(this.userService.getUserById(Integer.parseInt(params.get("userId"))));
        
        int sId = Integer.parseInt(params.get("shopId"));
        if(sId >= 1)
            shop.setId(sId);
        
        this.shopService.AddOrUpdateShop(shop);
        return new ResponseEntity<>(shop, HttpStatus.CREATED);
    }
}
