import axios from "axios";
import cookie from "react-cookies";

const SERVER_CONTEXT = "/BTLJava";
const SERVER = "http://localhost:8080";

export const endpoints = {
    "categories": `${SERVER_CONTEXT}/api/categories/`,
    "products": `${SERVER_CONTEXT}/api/products/`,
    "login": `${SERVER_CONTEXT}/api/login/`,
    "current-user": `${SERVER_CONTEXT}/api/current-user/`,
    "unactive-users": `${SERVER_CONTEXT}/api/unactiveusers/`,
    "update-sale-user": `${SERVER_CONTEXT}/api/update-sale-user/`,
    "register": `${SERVER_CONTEXT}/api/users/`,
    "pay": `${SERVER_CONTEXT}/api/pay/`,
    "details": (productId) => `${SERVER_CONTEXT}/api/products/${productId}/`,
    "comments": (productId) => `${SERVER_CONTEXT}/api/products/${productId}/comments/`,
    "add-comment": `${SERVER_CONTEXT}/api/comments/`,
    "shops": `${SERVER_CONTEXT}/api/shops/`,
    "shops-by-userid": (userId) => `${SERVER_CONTEXT}/api/shops-by-user-id/${userId}/`,
    "products-by-shopid": (shopId) => `${SERVER_CONTEXT}/api/products-by-shop-id/${shopId}/`,
    "shop-detail": (shopId) => `${SERVER_CONTEXT}/api/shops/${shopId}/`,
    "add-or-update-shop": `${SERVER_CONTEXT}/api/shop-add-update/`
}

export const authApi = () => {
    return axios.create({
        baseURL: SERVER,
        headers: {
            "Authorization":  cookie.load("token")
        }
    })
}

export default axios.create({
    baseURL: SERVER
})