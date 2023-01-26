const baseUrl = "http://10.0.2.2:90/";
const loginUrl = "customer/login";
const registerUrl = "customer/register";
const getProductsUrl = "customer/product";
//  cart router
const getCart = "get/cart/";
const addToCartURL = "cart/add";
const updateCart = "update/cart";
const deleteCart = "delete/cart/";

//  product router
const getProduct = "get/product";
const getUserProductURL = "get/product/user";
const getProductWithCategory = "get/product/category=";
const getOneProductURL = "get/product/";

const addProductURL = "product/add";
const updateProduct = "product/update/";
const removeProduct = "product/remove/";

// router.get("/get/review/:id", getReviewByProductId);
// router.post("/review/givereview", customerGuard, addReview);
// router.put("/review/update/:id", customerGuard, updateReview);
// router.delete("/review/delete/:id", customerGuard, deleteReview);
const getProductReview = "get/review/";
const addReview = "review/givereview";

// const
String? token;
String? userId;
