/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dht.controllers;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.dht.pojo.Comment;
import com.dht.pojo.Product;
import com.dht.service.CategoryService;
import com.dht.service.CommentService;
import com.dht.service.ProductService;
import com.dht.service.ShopService;
import com.dht.service.impl.ProductServiceImpl;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author admin
 */
@RestController
@RequestMapping("/api")
public class ApiProductController {

    @Autowired
    private ProductService prodService;
    @Autowired
    private CategoryService cateService;
    @Autowired
    private ShopService shopService;
    @Autowired
    private CommentService commentService;
    @Autowired
    private Cloudinary cloudinary;

    @DeleteMapping("/products/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void delete(@PathVariable(value = "id") int id) {
        this.prodService.deleteProduct(id);
    }

    @RequestMapping("/products/")
    @CrossOrigin
    public ResponseEntity<List<Product>> list(@RequestParam Map<String, String> params) {
        return new ResponseEntity<>(this.prodService.getProducts(params), HttpStatus.OK);
    }

    @RequestMapping(path = "/products/{productId}/", produces = MediaType.APPLICATION_JSON_VALUE)
    @CrossOrigin
    public ResponseEntity<Product> details(@PathVariable(value = "productId") int id) {
        return new ResponseEntity<>(this.prodService.getProductById(id), HttpStatus.OK);
    }

    @PostMapping(path = "/products/",
            consumes = {MediaType.MULTIPART_FORM_DATA_VALUE},
            produces = {MediaType.APPLICATION_JSON_VALUE})
    @CrossOrigin
    public ResponseEntity<Product> add(@RequestParam Map<String, String> params, @RequestPart MultipartFile file) {
        Product p = new Product();
        p.setName(params.get("name"));
        p.setDescription(params.get("description"));
        p.setPrice(Long.parseLong(params.get("price")));
        p.setCategoryId(this.cateService.getCateById(Integer.parseInt(params.get("categoryId"))));
        p.setShopId(this.shopService.getShopById(Integer.parseInt(params.get("shopId"))));
        
        if (!file.isEmpty()) {
            try {
                Map res = this.cloudinary
                        .uploader()
                        .upload(file.getBytes(), ObjectUtils.asMap("resource_type", "auto"));
                p.setImage(res.get("secure_url").toString());
            } catch (IOException ex) {
                Logger.getLogger(ProductServiceImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        this.prodService.addOrUpdateProduct(p);
        return new ResponseEntity<>(p, HttpStatus.CREATED);
    }

    @GetMapping("/products/{productId}/comments/")
    @CrossOrigin
    public ResponseEntity<List<Comment>> listComments(@PathVariable(value = "productId") int id) {
        return new ResponseEntity<>(this.commentService.getComments(id), HttpStatus.OK);
    }

    @PostMapping(path = "/comments/", produces = MediaType.APPLICATION_JSON_VALUE)
    @CrossOrigin
    public ResponseEntity<Comment> addComment(@RequestBody Comment comment) {
        Comment c = this.commentService.addComment(comment);

        return new ResponseEntity<>(c, HttpStatus.CREATED);
    }
}
