package com.gaminggear.model;

import java.math.BigDecimal;
import java.sql.Date;

public class Product {
    private int productId;
    private String productName;
    private String brandName;
    private BigDecimal price;
    private String productSpecification;
    private Date releaseDate;
    private String imagePath;  
    private int stock;         

    // --- Getters and Setters ---
    public int getProductId() {
        return productId;
    }
    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }
    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getBrandName() {
        return brandName;
    }
    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public BigDecimal getPrice() {
        return price;
    }
    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getProductSpecification() {
        return productSpecification;
    }
    public void setProductSpecification(String productSpecification) {
        this.productSpecification = productSpecification;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }
    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    public String getImagePath() {
        return imagePath;
    }
    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public int getStock() {
        return stock;
    }
    public void setStock(int stock) {
        this.stock = stock;
    }
    

}
