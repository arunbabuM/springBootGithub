package comspring.springboot.model;

import org.springframework.web.multipart.MultipartFile;

public class product {
    private int id;
    private String productName;
    private String productType;
    private String prize;
    private String image;

    

    public product(int id, String productName, String productType, String prize, String image, MultipartFile file) {
        this.id = id;
        this.productName = productName;
        this.productType = productType;
        this.prize = prize;
        this.image = image;
        this.file = file;
    }
    @Override
    public String toString() {
        return "product [id=" + id + ", productName=" + productName + ", productType=" + productType + ", prize="
                + prize + ", image=" + image + ", file=" + file + "]";
    }
    MultipartFile file;

    

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getProductName() {
        return productName;
    }
    public void setProductName(String productName) {
        this.productName = productName;
    }
    public String getProductType() {
        return productType;
    }
    public void setProductType(String productType) {
        this.productType = productType;
    }
    public String getPrize() {
        return prize;
    }
    public void setPrize(String prize) {
        this.prize = prize;
    }
    public String getImage() {
        return image;
    }
    public void setImage(String image) {
        this.image = image;
    }
    public MultipartFile getFile() {
        return file;
    }
    public void setFile(MultipartFile file) {
        this.file = file;
    }
    
}
